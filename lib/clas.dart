class Bloc {
  String title;
  String imgurl;
  String id;
  bool lik;
  Bloc({
    required this.title,
    required this.id,
    required this.imgurl,
    required this.lik,
  });
  factory Bloc.fromMap(Map<String, dynamic> json) {
    return Bloc(
      title: json["title"].toString(),
      id: json["id"].toString(),
      imgurl: json['image_url'].toString(),
      lik: true,
    );
  }
}
