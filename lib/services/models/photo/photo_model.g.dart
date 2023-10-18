// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoModelImpl _$$PhotoModelImplFromJson(Map<String, dynamic> json) =>
    _$PhotoModelImpl(
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => PhotoItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
      totalResults: json['total_results'] as int?,
    );

Map<String, dynamic> _$$PhotoModelImplToJson(_$PhotoModelImpl instance) =>
    <String, dynamic>{
      'photos': instance.photos,
      'page': instance.page,
      'per_page': instance.perPage,
      'total_results': instance.totalResults,
    };

_$PhotoItemModelImpl _$$PhotoItemModelImplFromJson(Map<String, dynamic> json) =>
    _$PhotoItemModelImpl(
      id: json['id'] as int,
      url: json['url'] as String,
      photographer: json['photographer'] as String,
      avgColor: json['avg_color'] as String,
      src: PhotoSrcModel.fromJson(json['src'] as Map<String, dynamic>),
      alt: json['alt'] as String?,
    );

Map<String, dynamic> _$$PhotoItemModelImplToJson(
        _$PhotoItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'photographer': instance.photographer,
      'avg_color': instance.avgColor,
      'src': instance.src,
      'alt': instance.alt,
    };

_$PhotoSrcModelImpl _$$PhotoSrcModelImplFromJson(Map<String, dynamic> json) =>
    _$PhotoSrcModelImpl(
      original: json['original'] as String,
      large: json['large'] as String,
      portrait: json['portrait'] as String,
    );

Map<String, dynamic> _$$PhotoSrcModelImplToJson(_$PhotoSrcModelImpl instance) =>
    <String, dynamic>{
      'original': instance.original,
      'large': instance.large,
      'portrait': instance.portrait,
    };
