import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final filled = rating >= index + 1;
        final half = rating > index && rating < index + 1;
        return Icon(
          filled ? Icons.star : half ? Icons.star_half : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}
