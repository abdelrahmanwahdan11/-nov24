import 'package:flutter/material.dart';
import '../models/product.dart';

class Product3DCard extends StatefulWidget {
  final Product product;
  const Product3DCard({super.key, required this.product});

  @override
  State<Product3DCard> createState() => _Product3DCardState();
}

class _Product3DCardState extends State<Product3DCard> {
  double tilt = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => tilt = 0.05),
      onTapUp: (_) => setState(() => tilt = 0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(tilt),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ClipOval(
              child: Image.network(widget.product.imageUrl, height: 100, width: 100, fit: BoxFit.cover),
            ),
            const SizedBox(height: 8),
            Text(widget.product.nameEn, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
