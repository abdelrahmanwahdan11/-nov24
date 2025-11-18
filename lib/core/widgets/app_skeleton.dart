import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppSkeleton extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? radius;

  const AppSkeleton({super.key, this.height = 16, this.width = double.infinity, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: radius ?? BorderRadius.circular(12),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: const Duration(milliseconds: 1200));
  }
}
