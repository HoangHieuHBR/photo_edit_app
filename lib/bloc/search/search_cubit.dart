import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_edit_app/repository/search/search_repo.dart';

import '../../services/models/models.dart';
import '../bloc_status.dart';

part 'search_state.dart';
part 'search_cubit.freezed.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;
  SearchCubit({
    required this.repo,
  }) : super(const SearchState());

  void onKeywordChanged(String value) {
    emit(state.copyWith(keyword: value));
  }

  void clearKeyword() {
    emit(state.copyWith(keyword: ''));
  }

  void searchPhotos({
    bool showLoading = true,
    int page = 1,
  }) async {
    if (showLoading) emit(state.copyWith(status: BlocStatus.loading));

    try {
      final result = await repo.searchPhotoByKeword(page, 24, state.keyword);

      if (page == 1) {
        emit(state.copyWith(
          status: BlocStatus.success,
          photos: result,
          photoPage: page,
          hasReachMax: result.isEmpty,
        ));

        return;
      }

      emit(state.copyWith(
        photoPage: page,
        hasReachMax: result.isEmpty,
        status: BlocStatus.success,
        photos: List.from(state.photos)..addAll(result),
      ));
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error));
    }
  }

  void fetchNextPhotos() {
    final nextPage = state.photoPage + 1;

    // if (state.hasReachMax) return;

    searchPhotos(
      showLoading: false,
      page: nextPage,
    );
  }
}
