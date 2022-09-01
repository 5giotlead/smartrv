// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Camp _$CampFromJson(Map<String, dynamic> json) => Camp(
      json['id'] as String,
      json['name'] as String?,
      json['region'] as String?,
      json['city'] as String?,
      json['fileName'] as String?,
    );

Map<String, dynamic> _$CampToJson(Camp instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'region': instance.region,
      'city': instance.city,
      'fileName': instance.fileName,
    };
