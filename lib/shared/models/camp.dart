import 'package:json_annotation/json_annotation.dart';

part 'camp.g.dart';

@JsonSerializable()
class Camp {
  Camp(this.id, this.name, this.region, this.city, this.fileName);

  factory Camp.fromJson(Map<String, dynamic> json) => _$CampFromJson(json);

  Map<String, dynamic> toJson() => _$CampToJson(this);

  String id;
  String? name;
  String? region;
  String? city;
  String? fileName;
}
