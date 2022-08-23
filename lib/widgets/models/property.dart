class Property {
  String name;
  String description;
  String imagePath;
  String price;

  Property(this.name, this.description, this.imagePath, this.price);
}

class HouseProperty {
  String name;
  String type;
  String location;
  String imagePath;

  HouseProperty(
      {required this.name,
      this.type = '',
      required this.location,
      required this.imagePath});
}
