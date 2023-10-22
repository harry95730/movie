class Bloc {
  int id;
  String title;
  int price;
  String description;
  List<dynamic> images;
  Map<String, dynamic> category;

  Bloc({
    required this.title,
    required this.id,
    required this.price,
    required this.category,
    required this.description,
    required this.images,
  });
  factory Bloc.fromMap(Map<String, dynamic> json) {
    return Bloc(
      title: json["title"].toString(),
      id: json["id"],
      category: json["category"] as Map<String, dynamic>,
      description: json["description"].toString(),
      images: json["images"] as List<dynamic>,
      price: json["price"],
    );
  }
}
