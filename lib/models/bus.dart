class Bus {
  final String id;
  final String operatorName;
  final String busNumber;
  final String busType; // 'AC Sleeper', 'AC Seater', 'Non-AC Seater', etc.
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final int availableSeats;
  final int totalSeats;
  final String from;
  final String to;
  final DateTime date;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final bool isAC;
  final bool isSleeper;

  Bus({
    required this.id,
    required this.operatorName,
    required this.busNumber,
    required this.busType,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.availableSeats,
    required this.totalSeats,
    required this.from,
    required this.to,
    required this.date,
    this.rating = 4.0,
    this.reviewCount = 0,
    this.amenities = const [],
    this.isAC = true,
    this.isSleeper = false,
  });

  int get bookedSeats => totalSeats - availableSeats;

  double get occupancyRate => bookedSeats / totalSeats;

  String get formattedPrice => '₹${price.toStringAsFixed(0)}';
}
