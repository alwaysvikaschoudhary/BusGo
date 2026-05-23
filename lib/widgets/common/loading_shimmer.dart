import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const LoadingShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class BusCardShimmer extends StatelessWidget {
  const BusCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color?.withValues(alpha: 0.3) ?? Colors.transparent,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingShimmer(width: 120, height: 18),
              LoadingShimmer(width: 60, height: 24, borderRadius: 12),
            ],
          ),
          SizedBox(height: 12),
          LoadingShimmer(width: 180, height: 14),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingShimmer(width: 80, height: 14),
              LoadingShimmer(width: 60, height: 14),
              LoadingShimmer(width: 80, height: 14),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              LoadingShimmer(width: 24, height: 24, borderRadius: 12),
              SizedBox(width: 8),
              LoadingShimmer(width: 24, height: 24, borderRadius: 12),
              SizedBox(width: 8),
              LoadingShimmer(width: 24, height: 24, borderRadius: 12),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingShimmer(width: 80, height: 16),
              LoadingShimmer(width: 100, height: 36, borderRadius: 12),
            ],
          ),
        ],
      ),
    );
  }
}
