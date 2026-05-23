import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../models/seat.dart';

class SeatWidget extends StatelessWidget {
  final Seat seat;
  final VoidCallback? onTap;
  final double size;

  const SeatWidget({
    super.key,
    required this.seat,
    this.onTap,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor;
    final Color textColor;
    final Color borderColor;

    switch (seat.status) {
      case SeatStatus.available:
        bgColor = isDark
            ? AppColors.seatAvailableDark.withValues(alpha: 0.15)
            : AppColors.seatAvailable.withValues(alpha: 0.1);
        textColor = isDark ? AppColors.seatAvailableDark : AppColors.seatAvailable;
        borderColor = isDark ? AppColors.seatAvailableDark : AppColors.seatAvailable;
      case SeatStatus.booked:
        bgColor = isDark ? AppColors.seatBookedDark : AppColors.seatBooked;
        textColor = isDark ? Colors.grey.shade600 : Colors.grey.shade400;
        borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;
      case SeatStatus.selected:
        bgColor = isDark ? AppColors.seatSelectedDark : AppColors.seatSelected;
        textColor = Colors.white;
        borderColor = isDark ? AppColors.seatSelectedDark : AppColors.seatSelected;
    }

    return GestureDetector(
      onTap: seat.status != SeatStatus.booked ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: seat.status == SeatStatus.selected ? 2 : 1.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (seat.status == SeatStatus.selected)
                Icon(Icons.check_rounded, size: 16, color: textColor)
              else if (seat.status == SeatStatus.booked)
                Icon(Icons.close_rounded, size: 14, color: textColor)
              else
                Icon(
                  seat.isWindow ? Icons.window : Icons.event_seat,
                  size: 14,
                  color: textColor,
                ),
              Text(
                seat.seatNumber,
                style: TextStyle(
                  color: textColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
