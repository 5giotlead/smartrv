import 'package:flutter_rv_pms/shared/models/comment.dart';
import 'package:flutter_rv_pms/shared/models/ord.dart';

class RV {
  RV(
    this.id,
    this.name,
    this.description,
    this.views,
    this.assetId,
    this.comments,
    this.ords,
  );

  late String id;
  late String name;
  late String description;
  late int views;
  late String assetId;
  late List<Comment> comments;
  late List<Ord> ords;
}
