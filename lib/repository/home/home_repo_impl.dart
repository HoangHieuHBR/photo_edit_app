import 'package:dio/dio.dart';
import 'package:photo_edit_app/repository/home/home_repo.dart';
import 'package:photo_edit_app/services/services.dart';

class HomeRepoImpl extends HomeRepo {
  final Dio client;

  HomeRepoImpl({required this.client});

  @override
  Future<List<CollectionItemModel>> fetchCollections(int perPage) async {
    try {
      final result = await client.get(
        '/collections/featured',
        options: ClientUtils.pexelAuth,
        queryParameters: {
          'per_page': perPage,
        },
      );

      if (result.statusCode == 200) {
        final resultFromJson = CollectionModel.fromJson(result.data);
        return resultFromJson.collections;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PhotoItemModel>> fetchPhotos(int perPage, int page) async {
    try {
      final result = await client.get(
        '/curated',
        options: ClientUtils.pexelAuth,
        queryParameters: {
          'per_page': perPage,
          'page': page,
        },
      );

      if (result.statusCode == 200) {
        final resultFromJson = PhotoModel.fromJson(result.data);
        return resultFromJson.photos;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
