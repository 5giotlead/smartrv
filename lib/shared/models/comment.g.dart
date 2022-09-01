// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['id'] as String,
      (json['rate'] as num?)?.toDouble(),
      json['description'] as String?,
      json['userId'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'rate': instance.rate,
      'description': instance.description,
      'userId': instance.userId,
    };
