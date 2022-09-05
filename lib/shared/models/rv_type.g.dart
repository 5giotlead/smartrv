// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rv_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RVType _$RVTypeFromJson(Map<String, dynamic> json) => RVType(
      json['id'] as String,
      json['typeName'] as String?,
      (json['filenames'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RVTypeToJson(RVType instance) => <String, dynamic>{
      'id': instance.id,
      'typeName': instance.typeName,
      'filenames': instance.filenames,
      'price': instance.price,
    };
