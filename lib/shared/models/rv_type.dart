import 'package:flutter_rv_pms/shared/models/camp.dart';
import 'package:flutter_rv_pms/shared/models/comment.dart';
import 'package:flutter_rv_pms/shared/models/ord.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rv_type.g.dart';

@JsonSerializable()
class RVType {
  RVType(this.id, this.typeName, this.filenames, this.price);

  factory RVType.fromJson(Map<String, dynamic> json) => _$RVTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RVTypeToJson(this);

  String id;
  String? typeName;
  List<String>? filenames;
  double? price;
}
