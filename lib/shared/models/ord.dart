import 'package:json_annotation/json_annotation.dart';

part 'ord.g.dart';

@JsonSerializable()
class Ord {
  Ord(
    this.id,
    this.state,
    this.total,
    this.startDate,
    this.endDate,
    this.userId,
    this.discountId,
  );

  factory Ord.fromJson(Map<String, dynamic> json) => _$OrdFromJson(json);

  Map<String, dynamic> toJson() => _$OrdToJson(this);

  String id;
  String? state;
  double? total;
  String? startDate;
  String? endDate;
  String? userId;
  String? discountId;
}
