import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/bus.dart';
import '../../data/mock_data.dart';

class BusCard extends StatelessWidget {
  final Bus bus;
  final VoidCallback? onTap;
  final VoidCallback? onSelectSeats;

  const BusCard({
    super.key,
    required this.bus,
    this.onTap,
    this.onSelectSeats,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color?.withValues(alpha: 0.3) ?? Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Operator & Type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        bus.operatorName,
                        style: theme.textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: bus.isAC
                            ? AppColors.primaryContainer
                            : theme.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        bus.busType,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: bus.isAC
                              ? AppColors.primary
                              : theme.colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  bus.busNumber,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),

                // Time row
                Row(
                  children: [
                    _buildTimeColumn(context, bus.departureTime, bus.from),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            bus.duration,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 1.5,
                                color: theme.dividerTheme.color,
                              ),
                              Icon(
                                Icons.directions_bus,
                                size: 16,
                                color: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildTimeColumn(context, bus.arrivalTime, bus.to, isEnd: true),
                  ],
                ),
                const SizedBox(height: 14),

                // Amenities
                if (bus.amenities.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: bus.amenities.take(4).map((amenity) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              MockData.getAmenityIcon(amenity),
                              size: 12,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              amenity,
                              style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                if (bus.amenities.isNotEmpty) const SizedBox(height: 14),

                // Bottom row: Rating, Seats, Price
                Row(
                  children: [
                    // Rating
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.ratingStar.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
                          const SizedBox(width: 3),
                          Text(
                            bus.rating.toStringAsFixed(1),
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.ratingStar,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Available seats
                    Text(
                      '${bus.availableSeats} seats left',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: bus.availableSeats <= 5
                            ? AppColors.error
                            : AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          bus.formattedPrice,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'per seat',
                          style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(BuildContext context, String time, String city, {bool isEnd = false}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          city,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
