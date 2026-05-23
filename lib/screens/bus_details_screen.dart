import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../data/mock_data.dart';
import '../models/bus.dart';
import 'seat_selection_screen.dart';

class BusDetailsScreen extends StatelessWidget {
  final Bus bus;

  const BusDetailsScreen({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverAppBar(
            expandedHeight: 125,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.heroGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bus.operatorName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                bus.busType,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              bus.busNumber,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Route & Time
                _buildSectionCard(
                  context,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bus.departureTime,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  bus.from,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                bus.duration,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 80,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 2,
                                      color: theme.dividerTheme.color,
                                    ),
                                    Icon(
                                      Icons.directions_bus_rounded,
                                      size: 18,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  bus.arrivalTime,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(bus.to, style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoItem(
                            context,
                            Icons.calendar_today_rounded,
                            DateFormat('dd MMM yyyy').format(bus.date),
                          ),
                          _buildInfoItem(
                            context,
                            Icons.event_seat_rounded,
                            '${bus.availableSeats} seats',
                          ),
                          _buildInfoItem(
                            context,
                            Icons.star_rounded,
                            '${bus.rating} (${bus.reviewCount})',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Amenities
                if (bus.amenities.isNotEmpty) ...[
                  Text('Amenities', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  _buildSectionCard(
                    context,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: bus.amenities.map((amenity) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                MockData.getAmenityIcon(amenity),
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(amenity, style: theme.textTheme.titleSmall),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Boarding & Dropping Points
                Text('Route Details', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 12),
                _buildSectionCard(
                  context,
                  child: Column(
                    children: [
                      _buildRoutePoint(
                        context,
                        bus.from,
                        bus.departureTime,
                        true,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 11),
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 16,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Journey time: ${bus.duration}',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildRoutePoint(context, bus.to, bus.arrivalTime, false),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Reviews Preview
                Text('Reviews', style: theme.textTheme.headlineSmall),
                const SizedBox(height: 12),
                _buildSectionCard(
                  context,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.ratingStar.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.ratingStar,
                                  size: 22,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  bus.rating.toStringAsFixed(1),
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        color: AppColors.ratingStar,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${bus.reviewCount} reviews',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                'Based on passenger ratings',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildReviewItem(
                        context,
                        'Rahul M.',
                        5,
                        'Great service, very comfortable!',
                      ),
                      const Divider(height: 20),
                      _buildReviewItem(
                        context,
                        'Priya S.',
                        4,
                        'Punctual departure, clean bus.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Space for bottom bar
              ]),
            ),
          ),
        ],
      ),

      // Sticky bottom CTA
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.dividerTheme.color ?? Colors.grey.shade200,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bus.formattedPrice,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text('per seat', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SeatSelectionScreen(bus: bus),
                      ),
                    );
                  },
                  child: const Text('Select Seats'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              theme.dividerTheme.color?.withValues(alpha: 0.3) ??
              Colors.transparent,
        ),
      ),
      child: child,
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 6),
        Text(text, style: theme.textTheme.labelMedium),
      ],
    );
  }

  Widget _buildRoutePoint(
    BuildContext context,
    String city,
    String time,
    bool isStart,
  ) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isStart ? AppColors.success : AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isStart ? Icons.trip_origin : Icons.location_on,
            size: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(city, style: theme.textTheme.titleMedium),
              Text(time, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(
    BuildContext context,
    String name,
    int stars,
    String comment,
  ) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            name[0],
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: theme.textTheme.titleSmall),
                  const SizedBox(width: 8),
                  ...List.generate(
                    5,
                    (i) => Icon(
                      i < stars
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: 14,
                      color: AppColors.ratingStar,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(comment, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
