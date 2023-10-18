import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_edit_app/repository/repository.dart';
import 'package:photo_edit_app/services/client/client.dart';

class MainModule {
  static void init() {
    GetIt.I.registerLazySingleton(
      () => Dio().initClient("https://api.pexels.com/v1/"),
    );

    GetIt.I.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(client: GetIt.I.get()),
    );

    GetIt.I.registerLazySingleton<SearchRepo>(
      () => SearchRepoImpl(client: GetIt.I.get()),
    );
  }
}
