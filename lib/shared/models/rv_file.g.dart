// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rv_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RVFile _$RVFileFromJson(Map<String, dynamic> json) => RVFile(
      json['id'] as String,
      json['originalName'] as String?,
      json['mediaType'] as String?,
      json['block'] as String?,
      json['access'] as String?,
    );

Map<String, dynamic> _$RVFileToJson(RVFile instance) => <String, dynamic>{
      'id': instance.id,
      'originalName': instance.originalName,
      'mediaType': instance.mediaType,
      'block': instance.block,
      'access': instance.access,
    };
