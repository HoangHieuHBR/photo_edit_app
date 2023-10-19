// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PhotoDetailState {
  DownloadStatus get downloadStatus => throw _privateConstructorUsedError;
  DownloadStatus get shareStatus => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotoDetailStateCopyWith<PhotoDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoDetailStateCopyWith<$Res> {
  factory $PhotoDetailStateCopyWith(
          PhotoDetailState value, $Res Function(PhotoDetailState) then) =
      _$PhotoDetailStateCopyWithImpl<$Res, PhotoDetailState>;
  @useResult
  $Res call({DownloadStatus downloadStatus, DownloadStatus shareStatus});
}

/// @nodoc
class _$PhotoDetailStateCopyWithImpl<$Res, $Val extends PhotoDetailState>
    implements $PhotoDetailStateCopyWith<$Res> {
  _$PhotoDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadStatus = null,
    Object? shareStatus = null,
  }) {
    return _then(_value.copyWith(
      downloadStatus: null == downloadStatus
          ? _value.downloadStatus
          : downloadStatus // ignore: cast_nullable_to_non_nullable
              as DownloadStatus,
      shareStatus: null == shareStatus
          ? _value.shareStatus
          : shareStatus // ignore: cast_nullable_to_non_nullable
              as DownloadStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoDetailStateImplCopyWith<$Res>
    implements $PhotoDetailStateCopyWith<$Res> {
  factory _$$PhotoDetailStateImplCopyWith(_$PhotoDetailStateImpl value,
          $Res Function(_$PhotoDetailStateImpl) then) =
      __$$PhotoDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DownloadStatus downloadStatus, DownloadStatus shareStatus});
}

/// @nodoc
class __$$PhotoDetailStateImplCopyWithImpl<$Res>
    extends _$PhotoDetailStateCopyWithImpl<$Res, _$PhotoDetailStateImpl>
    implements _$$PhotoDetailStateImplCopyWith<$Res> {
  __$$PhotoDetailStateImplCopyWithImpl(_$PhotoDetailStateImpl _value,
      $Res Function(_$PhotoDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadStatus = null,
    Object? shareStatus = null,
  }) {
    return _then(_$PhotoDetailStateImpl(
      downloadStatus: null == downloadStatus
          ? _value.downloadStatus
          : downloadStatus // ignore: cast_nullable_to_non_nullable
              as DownloadStatus,
      shareStatus: null == shareStatus
          ? _value.shareStatus
          : shareStatus // ignore: cast_nullable_to_non_nullable
              as DownloadStatus,
    ));
  }
}

/// @nodoc

class _$PhotoDetailStateImpl implements _PhotoDetailState {
  const _$PhotoDetailStateImpl(
      {this.downloadStatus = DownloadStatus.initial,
      this.shareStatus = DownloadStatus.initial});

  @override
  @JsonKey()
  final DownloadStatus downloadStatus;
  @override
  @JsonKey()
  final DownloadStatus shareStatus;

  @override
  String toString() {
    return 'PhotoDetailState(downloadStatus: $downloadStatus, shareStatus: $shareStatus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoDetailStateImpl &&
            (identical(other.downloadStatus, downloadStatus) ||
                other.downloadStatus == downloadStatus) &&
            (identical(other.shareStatus, shareStatus) ||
                other.shareStatus == shareStatus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, downloadStatus, shareStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoDetailStateImplCopyWith<_$PhotoDetailStateImpl> get copyWith =>
      __$$PhotoDetailStateImplCopyWithImpl<_$PhotoDetailStateImpl>(
          this, _$identity);
}

abstract class _PhotoDetailState implements PhotoDetailState {
  const factory _PhotoDetailState(
      {final DownloadStatus downloadStatus,
      final DownloadStatus shareStatus}) = _$PhotoDetailStateImpl;

  @override
  DownloadStatus get downloadStatus;
  @override
  DownloadStatus get shareStatus;
  @override
  @JsonKey(ignore: true)
  _$$PhotoDetailStateImplCopyWith<_$PhotoDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
