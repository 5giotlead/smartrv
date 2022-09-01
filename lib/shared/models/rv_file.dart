import 'package:json_annotation/json_annotation.dart';

part 'rv_file.g.dart';

@JsonSerializable()
class RVFile {
  RVFile(this.id, this.originalName, this.mediaType, this.block, this.access);

  factory RVFile.fromJson(Map<String, dynamic> json) => _$RVFileFromJson(json);

  Map<String, dynamic> toJson() => _$RVFileToJson(this);

  String id;
  String? originalName;
  String? mediaType;
  String? block;
  String? access;
}
