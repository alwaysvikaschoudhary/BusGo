import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../data/mock_data.dart';
import '../models/bus.dart';
import '../models/seat.dart';
import '../widgets/seat/seat_widget.dart';
import 'passenger_details_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Bus bus;

  const SeatSelectionScreen({super.key, required this.bus});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  late List<Seat> seats;
  List<String> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    seats = MockData.getSeatsForBus(widget.bus.id, widget.bus.price);
  }

  void _toggleSeat(Seat seat) {
    if (seat.status == SeatStatus.booked) return;

    setState(() {
      if (selectedSeats.contains(seat.seatNumber)) {
        selectedSeats.remove(seat.seatNumber);
        seat.status = SeatStatus.available;
      } else {
        if (selectedSeats.length >= 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Maximum 5 seats per booking'),
              backgroundColor: AppColors.warning,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
          return;
        }
        selectedSeats.add(seat.seatNumber);
        seat.status = SeatStatus.selected;
      }
    });
  }

  double get totalPrice {
    double total = 0;
    for (final seatNumber in selectedSeats) {
      final seat = seats.firstWhere((s) => s.seatNumber == seatNumber);
      total += seat.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Seats'),
            Text(
              '${widget.bus.operatorName} · ${widget.bus.busNumber}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Legend
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend(context, 'Available',
                    isDark ? AppColors.seatAvailableDark : AppColors.seatAvailable),
                _buildLegend(context, 'Selected',
                    isDark ? AppColors.seatSelectedDark : AppColors.seatSelected),
                _buildLegend(context, 'Booked',
                    isDark ? AppColors.seatBookedDark : AppColors.seatBooked),
              ],
            ),
          ),
          const Divider(height: 1),

          // Seat grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Bus front
                  Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      border: Border.all(
                        color: theme.dividerTheme.color ?? Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.airline_seat_recline_normal_rounded,
                            size: 20, color: theme.textTheme.bodySmall?.color),
                        const SizedBox(width: 8),
                        Text('Front', style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),

                  // Seat rows
                  Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: theme.dividerTheme.color ?? Colors.grey.shade200,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Column labels
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildColumnLabel(context, 'W'),
                              const SizedBox(width: 8),
                              _buildColumnLabel(context, 'A'),
                              const SizedBox(width: 24), // Aisle
                              _buildColumnLabel(context, 'A'),
                              const SizedBox(width: 8),
                              _buildColumnLabel(context, 'W'),
                            ],
                          ),
                        ),
                        // Seat rows
                        for (int row = 0; row < 10; row++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Left pair (A, B)
                                SeatWidget(
                                  seat: seats[row * 5 + 0],
                                  onTap: () => _toggleSeat(seats[row * 5 + 0]),
                                ),
                                const SizedBox(width: 8),
                                SeatWidget(
                                  seat: seats[row * 5 + 1],
                                  onTap: () => _toggleSeat(seats[row * 5 + 1]),
                                ),
                                // Aisle
                                SizedBox(
                                  width: 24,
                                  child: Center(
                                    child: Text(
                                      '${row + 1}',
                                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
                                    ),
                                  ),
                                ),
                                // Right pair (C, D) — skip column E (index 2 in 5-col layout)
                                SeatWidget(
                                  seat: seats[row * 5 + 2],
                                  onTap: () => _toggleSeat(seats[row * 5 + 2]),
                                ),
                                const SizedBox(width: 8),
                                SeatWidget(
                                  seat: seats[row * 5 + 3],
                                  onTap: () => _toggleSeat(seats[row * 5 + 3]),
                                ),
                              ],
                            ),
                          ),
                        // Last row — 5 seats (back row)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int col = 0; col < 5; col++) ...[
                                SeatWidget(
                                  seat: seats[49],  // just show last few seats
                                  size: 40,
                                ),
                                if (col < 4) const SizedBox(width: 4),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bus back
                  Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                      border: Border.all(
                        color: theme.dividerTheme.color ?? Colors.grey.shade200,
                      ),
                    ),
                    child: Center(
                      child: Text('Rear', style: theme.textTheme.labelMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Sticky bottom bar
      bottomNavigationBar: selectedSeats.isNotEmpty
          ? Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(color: theme.dividerTheme.color ?? Colors.grey.shade200),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Selected seats chips
                    Row(
                      children: [
                        Text('Seats: ', style: theme.textTheme.titleSmall),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Wrap(
                            spacing: 6,
                            children: selectedSeats.map((s) => Chip(
                              label: Text(s, style: const TextStyle(fontSize: 12)),
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${totalPrice.toStringAsFixed(0)}',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '${selectedSeats.length} seat${selectedSeats.length > 1 ? 's' : ''} selected',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PassengerDetailsScreen(
                                    bus: widget.bus,
                                    selectedSeats: selectedSeats,
                                    totalPrice: totalPrice,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Continue'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildLegend(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color.withValues(alpha: color == AppColors.seatBooked || color == AppColors.seatBookedDark ? 1.0 : 0.15),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  Widget _buildColumnLabel(BuildContext context, String label) {
    return SizedBox(
      width: 44,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
