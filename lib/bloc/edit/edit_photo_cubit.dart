import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../screens/edit/components/components.dart';
import '../download_status.dart';

part 'edit_photo_state.dart';
part 'edit_photo_cubit.freezed.dart';

class EditPhotoCubit extends Cubit<EditPhotoState> {
  EditPhotoCubit() : super(const EditPhotoState());

  void changeEditState(EditState editState) {
    emit(state.copyWith(editState: editState));
  }

  void changeOpacityLayer(double value) {
    emit(state.copyWith(opacityLayer: value));
  }

  void addWidget(DragableWidget widget) {
    emit(state.copyWith(
      widgets: [...state.widgets, widget],
    ));
  }

  void editWidget(int widgetId, DragableWidgetChild widget) {
    var index = state.widgets.indexWhere((e) => e.widgetId == widgetId);
    if (index == -1) return;

    state.widgets[index].child = widget;

    emit(state.copyWith(
      editState: EditState.idle,
      widgets: [...state.widgets],
    ));
  }

  void changeDownloadStatus(DownloadStatus status) {
    emit(state.copyWith(downloadStatus: status));
  }

  void changeShareStatus(DownloadStatus status) {
    emit(state.copyWith(shareStatus: status));
  }

  void deleteWidget(int widgetId) {
    emit(
      state.copyWith(
        widgets: List.of(state.widgets)
          ..removeWhere((e) => e.widgetId == widgetId),
      ),
    );
  }

  void shareImage(Uint8List? image) async {
    emit(state.copyWith(shareStatus: DownloadStatus.downloading));

    final date = DateTime.now().millisecondsSinceEpoch;
    final directory = await getTemporaryDirectory();

    try {
      if (image == null) {
        emit(state.copyWith(shareStatus: DownloadStatus.failed));
        return;
      }

      final path = directory.path;
      final file = await File("$path/$date.jpeg").create();
      await file.writeAsBytes(image);
      emit(state.copyWith(shareStatus: DownloadStatus.success));
      final xFile = XFile(path);
      await Share.shareXFiles([xFile]);
    } catch (e) {
      emit(state.copyWith(shareStatus: DownloadStatus.failed));
    } finally {
      emit(state.copyWith(shareStatus: DownloadStatus.initial));
    }
  }

  void downloadImage(Uint8List? image) async {
    emit(state.copyWith(downloadStatus: DownloadStatus.downloading));

    final date = DateTime.now().millisecondsSinceEpoch;
    final directory = await _getDirectory();

    if (directory == null) return;

    try {
      if (image == null) {
        emit(state.copyWith(downloadStatus: DownloadStatus.failed));
        return;
      }
      final path = directory.path;
      final file = await File("$path/$date.jpeg").create();
      await file.writeAsBytes(image);
      emit(state.copyWith(downloadStatus: DownloadStatus.success));
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

      String newPath = "";
      final paths = directory?.path.split("/");
      for (var i = 1; i < (paths?.length ?? 0); i++) {
        String path = paths?[i] ?? "";
        if (path == "Android") break;
        newPath += "/$path";
      }

      newPath += "/Pictures/Pexel";

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
