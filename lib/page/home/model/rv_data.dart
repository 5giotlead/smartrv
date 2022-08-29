import 'package:flutter/cupertino.dart';

class Comments {
  const Comments({
    this.id = '',
    this.rate = 0.0,
    this.description = '',
    this.userId = '',
  });

  final String id;
  final double rate;
  final String description;
  final String userId;

  factory Comments.fromJson(dynamic json) {
    return Comments(
      id: (json['id'] != null) ? json['id'] as String : '',
      rate: (json['rate'] != null) ? json['rate'] as double : 0.0,
      description:
          (json['description'] != null) ? json['description'] as String : '',
      userId: (json['userId'] != null) ? json['userId'] as String : '',
    );
  }
}

class Ords {
  const Ords({
    this.id = '',
    this.state = '',
    this.total = 0.0,
    this.startDate = '',
    this.endDate = '',
    this.userId = '',
    this.discountId = '',
  });

  final String id;
  final String state;
  final double total;
  final String startDate;
  final String endDate;
  final String userId;
  final String discountId;

  factory Ords.fromJson(dynamic json) {
    return Ords(
      id: (json['id'] != null) ? json['id'] as String : '',
      state: (json['state'] != null) ? json['state'] as String : '',
      total: (json['total'] != null) ? json['total'] as double : 0.0,
      startDate: (json['startDate'] != null) ? json['startDate'] as String : '',
      endDate: (json['endDate'] != null) ? json['endDate'] as String : '',
      userId: (json['userId'] != null) ? json['userId'] as String : '',
      discountId:
          (json['discountId'] != null) ? json['discountId'] as String : '',
    );
  }
}

class RvData {
  RvData({
    required this.id,
    this.name = '',
    this.description = '',
    this.views = 0,
    this.assetId = '',
    this.comments = const Comments(),
    this.ords = const Ords(),
  });

  String id;
  String name;
  String description;
  int views;
  String assetId;
  Comments comments;
  Ords ords;

  factory RvData.fromJson(dynamic json) {
    return RvData(
      id: (json['id'] != null) ? json['id'] as String : '',
      name: (json['name'] != null) ? json['name'] as String : '',
      description:
          (json['description'] != null) ? json['description'] as String : '',
      views: (json['views'] != null) ? json['views'] as int : 0,
      assetId: (json['assetId'] != null) ? json['assetId'] as String : '',
      comments: Comments.fromJson(json['comments'][0]),
      ords: Ords.fromJson(json['ords'][0]),
    );
  }
}

class User {
  String name;
  int age;
  User(this.name, this.age);
  factory User.fromJson(dynamic json) {
    return User(
      json['name'] as String,
      (json['age'] != null) ? json['age'] as int : 10,
    );
  }
}

class Tutorial {
  String title;
  String description;
  User author;
  Tutorial(this.title, this.description, this.author);
  factory Tutorial.fromJson(dynamic json) {
    return Tutorial(json['title'] as String, json['description'] as String,
        User.fromJson(json['author'][0]));
  }
}
