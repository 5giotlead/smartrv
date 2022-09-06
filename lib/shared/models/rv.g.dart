// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RV _$RVFromJson(Map<String, dynamic> json) => RV(
      json['id'] as String,
      json['name'] as String?,
      json['description'] as String?,
      json['views'] as int?,
      json['assetId'] as String?,
      json['camp'] == null
          ? null
          : Camp.fromJson(json['camp'] as Map<String, dynamic>),
      json['type'] == null
          ? null
          : RVType.fromJson(json['type'] as Map<String, dynamic>),
      (json['comments'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ords'] as List<dynamic>)
          .map(
              (e) => e == null ? null : Ord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RVToJson(RV instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'views': instance.views,
      'assetId': instance.assetId,
      'camp': instance.camp,
      'type': instance.type,
      'comments': instance.comments,
      'ords': instance.ords,
    };
