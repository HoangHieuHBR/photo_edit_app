import 'package:dio/dio.dart';
import 'package:photo_edit_app/repository/search/search_repo.dart';

import '../../services/services.dart';

class SearchRepoImpl extends SearchRepo {
  final Dio client;

  SearchRepoImpl({
    required this.client,
  });

  @override
  Future<List<PhotoItemModel>> searchPhotoByKeword(
    int page,
    int perPage,
    String keyword,
  ) async {
    try {
      final result = await client.get(
        '/search',
        options: ClientUtils.pexelAuth,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          'query': keyword,
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
