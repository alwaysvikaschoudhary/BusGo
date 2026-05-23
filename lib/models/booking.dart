import 'bus.dart';
import 'passenger.dart';

enum BookingStatus { confirmed, completed, cancelled, upcoming }

class Booking {
  final String bookingId;
  final Bus bus;
  final List<String> seatNumbers;
  final Passenger passenger;
  final double totalPrice;
  final BookingStatus status;
  final DateTime bookingDate;
  final String paymentMethod;

  Booking({
    required this.bookingId,
    required this.bus,
    required this.seatNumbers,
    required this.passenger,
    required this.totalPrice,
    required this.status,
    required this.bookingDate,
    this.paymentMethod = 'UPI',
  });

  String get formattedTotal => '₹${totalPrice.toStringAsFixed(0)}';

  String get statusLabel {
    switch (status) {
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.upcoming:
        return 'Upcoming';
    }
  }
}
