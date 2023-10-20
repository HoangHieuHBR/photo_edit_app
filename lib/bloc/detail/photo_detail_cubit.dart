import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_edit_app/bloc/download_status.dart';
import 'package:share_plus/share_plus.dart';

part 'photo_detail_state.dart';
part 'photo_detail_cubit.freezed.dart';

class PhotoDetailCubit extends Cubit<PhotoDetailState> {
  final dio = Dio();
  PhotoDetailCubit() : super(const PhotoDetailState());

  void sharePhoto(String photoUrl) async {
    if (state.shareStatus == DownloadStatus.downloading) return;

    try {
      emit(state.copyWith(shareStatus: DownloadStatus.downloading));

      final response = await dio.get(photoUrl,
          options: Options(responseType: ResponseType.bytes));
      final bytes = response.data;

      final temp = await getTemporaryDirectory();
      final path = "${temp.path}/shared_image.jpeg";
      File(path).writeAsBytesSync(bytes);

      if (response.statusCode == 200) {
        emit(state.copyWith(shareStatus: DownloadStatus.success));
        final xFile = XFile(path);
        await Share.shareXFiles([xFile]);
      }
    } catch (e) {
      emit(state.copyWith(shareStatus: DownloadStatus.failed));
    } finally {
      emit(state.copyWith(shareStatus: DownloadStatus.initial));
    }
  }

  void downloadPhoto(String photoUrl) async {
    if (state.downloadStatus == DownloadStatus.downloading) return;

    final date = DateTime.now().millisecondsSinceEpoch;
    final directory = await _getDirectory();

    if (directory == null) return;

    try {
      final path = directory.path;
      final file = File('$path/$date.jpeg');
      emit(state.copyWith(downloadStatus: DownloadStatus.downloading));
      final response = await dio.download(
        photoUrl,
        file.path,
        deleteOnError: true,
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(downloadStatus: DownloadStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(downloadStatus: DownloadStatus.failed));
    } finally {
      emit(state.copyWith(downloadStatus: DownloadStatus.initial));
    }
  }

  Future<Directory?> _getDirectory() async {
    Directory? directory;
    PermissionStatus status;

    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      var storage = await Permission.storage.isGranted;

      if (!storage) {
        status = await Permission.storage.request();
        if (!status.isGranted) return null;
      }

      var externalStorage = await Permission.manageExternalStorage.isGranted;
      if (!externalStorage) {
        if ((info.version.sdkInt) >= 33) {
          status = await Permission.manageExternalStorage.request();
        } else {
          status = await Permission.storage.request();
        }
        if (!status.isGranted) return null;
      }

      directory = await getExternalStorageDirectory();

      String newPath = '';
      final paths = directory?.path.split('/');
      for (var i = 1; i < (paths?.length ?? 0); i++) {
        String path = paths?[i] ?? '';
        if (path == "Android") break;
        newPath += '/$path';
      }

      newPath += '/Pictures/Pexel';

      directory = Directory(newPath);
    } else {
      var photos = await Permission.photos.isGranted;
      if (!photos) {
        status = await Permission.photos.request();
        if (!status.isGranted) return null;
      }

      directory = await getApplicationDocumentsDirectory();
    }

    if (!await directory.exists()) {
      directory.create(recursive: true);
    }

    return directory;
  }
}
