import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../data/mock_data.dart';
import '../models/booking.dart';
import '../widgets/common/empty_state.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Booking> _bookings;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _bookings = MockData.sampleBookings;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Booking> _filterBookings(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return _bookings
            .where((b) =>
                b.status == BookingStatus.upcoming ||
                b.status == BookingStatus.confirmed)
            .toList();
      case 1:
        return _bookings
            .where((b) => b.status == BookingStatus.completed)
            .toList();
      case 2:
        return _bookings
            .where((b) => b.status == BookingStatus.cancelled)
            .toList();
      default:
        return _bookings;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
          labelStyle: theme.textTheme.titleMedium,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(0),
          _buildBookingList(1),
          _buildBookingList(2),
        ],
      ),
    );
  }

  Widget _buildBookingList(int tabIndex) {
    final bookings = _filterBookings(tabIndex);
    if (bookings.isEmpty) {
      return EmptyState(
        icon: tabIndex == 2
            ? Icons.cancel_outlined
            : tabIndex == 1
                ? Icons.check_circle_outline
                : Icons.receipt_long_outlined,
        title: tabIndex == 0
            ? 'No Upcoming Trips'
            : tabIndex == 1
                ? 'No Completed Trips'
                : 'No Cancelled Trips',
        subtitle: tabIndex == 0
            ? 'Your next adventure awaits! Search for buses now.'
            : 'Nothing to show here yet.',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        setState(() => _bookings = MockData.sampleBookings);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          return _buildBookingCard(context, bookings[index]);
        },
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Booking booking) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(booking.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    booking.bus.operatorName,
                    style: theme.textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking.statusLabel,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Route & Time
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.bus.departureTime, style: theme.textTheme.titleMedium),
                    Text(booking.bus.from, style: theme.textTheme.bodySmall),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 20, height: 1, color: theme.dividerTheme.color),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.directions_bus_rounded,
                              size: 16, color: theme.colorScheme.primary),
                        ),
                        Container(width: 20, height: 1, color: theme.dividerTheme.color),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(booking.bus.arrivalTime, style: theme.textTheme.titleMedium),
                    Text(booking.bus.to, style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Bottom row
            Row(
              children: [
                Icon(Icons.calendar_today_rounded,
                    size: 14, color: theme.textTheme.bodySmall?.color),
                const SizedBox(width: 6),
                Text(
                  DateFormat('dd MMM yyyy').format(booking.bus.date),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(Icons.event_seat_rounded,
                    size: 14, color: theme.textTheme.bodySmall?.color),
                const SizedBox(width: 6),
                Text(
                  booking.seatNumbers.join(', '),
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  booking.formattedTotal,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.confirmed:
      case BookingStatus.upcoming:
        return AppColors.primary;
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }
}
