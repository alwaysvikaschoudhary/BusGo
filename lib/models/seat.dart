enum SeatStatus { available, booked, selected }
enum SeatType { seater, sleeper, semiSleeper }

class Seat {
  final String seatNumber;
  SeatStatus status;
  final double price;
  final SeatType seatType;
  final int row;
  final int column;
  final bool isWindow;
  final bool isAisle;

  Seat({
    required this.seatNumber,
    required this.status,
    required this.price,
    this.seatType = SeatType.seater,
    required this.row,
    required this.column,
    this.isWindow = false,
    this.isAisle = false,
  });
}
