class TripPackageModel {
  int id;
  String title;
  String location;
  String availableDate;
  int price;
  List<String> images;
  String description;

  TripPackageModel({
    required this.id,
    required this.title,
    required this.location,
    required this.availableDate,
    required this.price,
    required this.images,
    required this.description,
  });
}
