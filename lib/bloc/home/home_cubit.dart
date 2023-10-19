import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_edit_app/bloc/bloc_status.dart';
import 'package:photo_edit_app/repository/repository.dart';

import '../../services/services.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  HomeCubit({
    required this.repo,
  }) : super(const HomeState());

  void fetchCollection({
    bool showLoading = true,
  }) async {
    if (showLoading) emit(state.copyWith(collectionStatus: BlocStatus.loading));

    try {
      final result = await repo.fetchCollections(30);
      if (!showLoading) {
        emit(state.copyWith(collectionStatus: BlocStatus.loading));
      }
      emit(state.copyWith(
        collectionStatus: BlocStatus.success,
        collections: result,
      ));
    } catch (e) {
      if (!showLoading) {
        emit(state.copyWith(collectionStatus: BlocStatus.loading));
      }
      emit(state.copyWith(collectionStatus: BlocStatus.error));
    }
  }

  void fetchPhotos({
    bool showLoading = true,
    int page = 1,
  }) async {
    if (showLoading) emit(state.copyWith(photoStatus: BlocStatus.loading));
    try {
      final result = await repo.fetchPhotos(24, page);

      if (page == 1) {
        emit(state.copyWith(
          photoStatus: BlocStatus.success,
          hasReachMax: result.isEmpty,
          photos: result,
          photoPage: page,
        ));

        return;
      }

      emit(state.copyWith(
        photoStatus: BlocStatus.success,
        hasReachMax: result.isEmpty,
        photos: List.from(state.photos)..addAll(result),
        photoPage: page,
      ));
    } catch (e) {
      if (!showLoading) {
        emit(state.copyWith(photoStatus: BlocStatus.loading));
      }
      emit(state.copyWith(photoStatus: BlocStatus.error));
    }
  }

  void fetchNextPhotos() {
    final nextPage = state.photoPage + 1;

    if (state.hasReachMax) return;

    fetchPhotos(
      showLoading: false,
      page: nextPage,
    );
  }
}
