import 'package:photo_edit_app/services/models/models.dart';

abstract class HomeRepo {
  Future<List<CollectionItemModel>> fetchCollections(int perPage);

  Future<List<PhotoItemModel>> fetchPhotos(int perPage, int page);
}
