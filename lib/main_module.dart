import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_edit_app/services/client/client.dart';

class MainModule {
  static void init() {
    GetIt.I.registerLazySingleton(
      () => Dio().initClient("https://api.pexels.com/v1/"),
    );
  }
}