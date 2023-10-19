part of 'photo_detail_cubit.dart';

@freezed
class PhotoDetailState with _$PhotoDetailState {
  const factory PhotoDetailState({
    @Default(DownloadStatus.initial) DownloadStatus downloadStatus,
    @Default(DownloadStatus.initial) DownloadStatus shareStatus,
  }) = _PhotoDetailState;
}
