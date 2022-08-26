class Comments {
  const Comments({
    this.id = '',
    this.rate = '',
    this.description = '',
    this.userId = '',
  });

  final String id;
  final String rate;
  final String description;
  final String userId;
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
}
