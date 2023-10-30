import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating; // Rating value from 0 to 5
  final double starSize;

  const RatingStars({super.key, required this.rating, this.starSize = 30.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(
            Icons.star,
            color: Colors.yellow,
            size: starSize,
          );
        } else {
          return Icon(
            Icons.star_border,
            color: Colors.yellow,
            size: starSize,
          );
        }
      }),
    );
  }
}
