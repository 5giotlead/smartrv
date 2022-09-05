import 'package:flutter_rv_pms/shared/models/camp.dart';
import 'package:flutter_rv_pms/shared/models/comment.dart';
import 'package:flutter_rv_pms/shared/models/ord.dart';
import 'package:flutter_rv_pms/shared/models/rv_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rv.g.dart';

@JsonSerializable()
class RV {
  RV(
    this.id,
    this.name,
    this.description,
    this.views,
    this.assetId,
    this.camp,
    this.type,
    this.comments,
    this.ords,
  );

  factory RV.fromJson(Map<String, dynamic> json) => _$RVFromJson(json);

  Map<String, dynamic> toJson() => _$RVToJson(this);

  String id;
  String? name;
  String? description;
  int? views;
  String? assetId;
  Camp? camp;
  RVType? type;
  List<Comment>? comments;
  List<Ord>? ords;
}
