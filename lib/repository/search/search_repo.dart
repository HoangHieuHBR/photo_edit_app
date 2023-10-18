import '../../services/models/models.dart';

abstract class SearchRepo {
  Future<List<PhotoItemModel>> searchPhotoByKeword(
    int page,
    int perPage,
    String keyword,
  );
}
