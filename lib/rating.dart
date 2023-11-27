import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final num rating;
  final int starCount;
  final Color color;
  final bool br;

  const StarRating(
      {super.key,
      required this.rating,
      this.starCount = 5,
      this.color = Colors.yellow,
      required this.br});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(starCount, (index) {
              if (index < rating.floor()) {
                return Icon(Icons.star, color: color, size: br ? 10.0 : 20.0);
              } else if (index == rating.floor()) {
                return Icon(Icons.star_half,
                    color: color, size: br ? 10.0 : 20.0);
              } else {
                return Icon(Icons.star_border,
                    color: color, size: br ? 10.0 : 20.0);
              }
            }),
          ),
        ),
      ),
    );
  }
}
