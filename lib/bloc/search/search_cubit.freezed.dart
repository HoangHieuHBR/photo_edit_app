// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchState {
  String get keyword => throw _privateConstructorUsedError;
  int get photoPage => throw _privateConstructorUsedError;
  bool get hasReachMax => throw _privateConstructorUsedError;
  BlocStatus get status => throw _privateConstructorUsedError;
  List<PhotoItemModel> get photos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {String keyword,
      int photoPage,
      bool hasReachMax,
      BlocStatus status,
      List<PhotoItemModel> photos});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
    Object? photoPage = null,
    Object? hasReachMax = null,
    Object? status = null,
    Object? photos = null,
  }) {
    return _then(_value.copyWith(
      keyword: null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      photoPage: null == photoPage
          ? _value.photoPage
          : photoPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachMax: null == hasReachMax
          ? _value.hasReachMax
          : hasReachMax // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoItemModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
          _$SearchStateImpl value, $Res Function(_$SearchStateImpl) then) =
      __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String keyword,
      int photoPage,
      bool hasReachMax,
      BlocStatus status,
      List<PhotoItemModel> photos});
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
      _$SearchStateImpl _value, $Res Function(_$SearchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = null,
    Object? photoPage = null,
    Object? hasReachMax = null,
    Object? status = null,
    Object? photos = null,
  }) {
    return _then(_$SearchStateImpl(
      keyword: null == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String,
      photoPage: null == photoPage
          ? _value.photoPage
          : photoPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachMax: null == hasReachMax
          ? _value.hasReachMax
          : hasReachMax // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotoItemModel>,
    ));
  }
}

/// @nodoc

class _$SearchStateImpl implements _SearchState {
  const _$SearchStateImpl(
      {this.keyword = "",
      this.photoPage = 1,
      this.hasReachMax = false,
      this.status = BlocStatus.initial,
      final List<PhotoItemModel> photos = const []})
      : _photos = photos;

  @override
  @JsonKey()
  final String keyword;
  @override
  @JsonKey()
  final int photoPage;
  @override
  @JsonKey()
  final bool hasReachMax;
  @override
  @JsonKey()
  final BlocStatus status;
  final List<PhotoItemModel> _photos;
  @override
  @JsonKey()
  List<PhotoItemModel> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString() {
    return 'SearchState(keyword: $keyword, photoPage: $photoPage, hasReachMax: $hasReachMax, status: $status, photos: $photos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.photoPage, photoPage) ||
                other.photoPage == photoPage) &&
            (identical(other.hasReachMax, hasReachMax) ||
                other.hasReachMax == hasReachMax) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @override
  int get hashCode => Object.hash(runtimeType, keyword, photoPage, hasReachMax,
      status, const DeepCollectionEquality().hash(_photos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState implements SearchState {
  const factory _SearchState(
      {final String keyword,
      final int photoPage,
      final bool hasReachMax,
      final BlocStatus status,
      final List<PhotoItemModel> photos}) = _$SearchStateImpl;

  @override
  String get keyword;
  @override
  int get photoPage;
  @override
  bool get hasReachMax;
  @override
  BlocStatus get status;
  @override
  List<PhotoItemModel> get photos;
  @override
  @JsonKey(ignore: true)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
