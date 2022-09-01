// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ord _$OrdFromJson(Map<String, dynamic> json) => Ord(
      json['id'] as String,
      json['state'] as String?,
      (json['total'] as num?)?.toDouble(),
      json['startDate'] as String?,
      json['endDate'] as String?,
      json['userId'] as String?,
      json['discountId'] as String?,
    );

Map<String, dynamic> _$OrdToJson(Ord instance) => <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'total': instance.total,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'userId': instance.userId,
      'discountId': instance.discountId,
    };
