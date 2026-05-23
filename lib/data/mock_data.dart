import 'package:flutter/material.dart';
import '../models/bus.dart';
import '../models/seat.dart';
import '../models/booking.dart';
import '../models/passenger.dart';
import '../models/route_info.dart';

class MockData {
  static const List<String> cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Pune',
    'Kolkata',
    'Ahmedabad',
    'Jaipur',
    'Lucknow',
    'Kochi',
    'Goa',
    'Chandigarh',
    'Nagpur',
    'Surat',
  ];

  static List<RouteInfo> get featuredRoutes => [
    RouteInfo(
      from: 'Mumbai',
      to: 'Pune',
      distance: '148 km',
      estimatedTime: '3h 30m',
      startingPrice: 350,
      icon: Icons.location_city,
      gradientColors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
    ),
    RouteInfo(
      from: 'Delhi',
      to: 'Jaipur',
      distance: '281 km',
      estimatedTime: '5h 30m',
      startingPrice: 450,
      icon: Icons.fort,
      gradientColors: [const Color(0xFFf093fb), const Color(0xFFf5576c)],
    ),
    RouteInfo(
      from: 'Bangalore',
      to: 'Chennai',
      distance: '346 km',
      estimatedTime: '6h 00m',
      startingPrice: 550,
      icon: Icons.temple_hindu,
      gradientColors: [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
    ),
    RouteInfo(
      from: 'Hyderabad',
      to: 'Goa',
      distance: '662 km',
      estimatedTime: '10h 30m',
      startingPrice: 800,
      icon: Icons.beach_access,
      gradientColors: [const Color(0xFF43e97b), const Color(0xFF38f9d7)],
    ),
    RouteInfo(
      from: 'Kolkata',
      to: 'Lucknow',
      distance: '986 km',
      estimatedTime: '14h 00m',
      startingPrice: 950,
      icon: Icons.landscape,
      gradientColors: [const Color(0xFFfa709a), const Color(0xFFfee140)],
    ),
  ];

  static List<Bus> getBusesForSearch(String from, String to, DateTime date) {
    final allBuses = [
      Bus(
        id: '1',
        operatorName: 'Royal Cruiser',
        busNumber: 'RJ-01-AB-1234',
        busType: 'AC Sleeper',
        departureTime: '08:00 PM',
        arrivalTime: '06:00 AM',
        duration: '10h 00m',
        price: 1200.0,
        availableSeats: 15,
        totalSeats: 36,
        from: 'Mumbai',
        to: 'Pune',
        date: date,
        rating: 4.5,
        reviewCount: 342,
        amenities: ['WiFi', 'Charging', 'Blanket', 'Water', 'Snacks'],
        isAC: true,
        isSleeper: true,
      ),
      Bus(
        id: '2',
        operatorName: 'IntrCity SmartBus',
        busNumber: 'MH-02-CD-5678',
        busType: 'AC Seater',
        departureTime: '06:30 AM',
        arrivalTime: '10:00 AM',
        duration: '3h 30m',
        price: 450.0,
        availableSeats: 22,
        totalSeats: 45,
        from: 'Mumbai',
        to: 'Pune',
        date: date,
        rating: 4.2,
        reviewCount: 189,
        amenities: ['WiFi', 'Charging', 'Water'],
        isAC: true,
        isSleeper: false,
      ),
      Bus(
        id: '3',
        operatorName: 'Neeta Travels',
        busNumber: 'MH-03-EF-9012',
        busType: 'Non-AC Seater',
        departureTime: '10:00 AM',
        arrivalTime: '02:00 PM',
        duration: '4h 00m',
        price: 280.0,
        availableSeats: 30,
        totalSeats: 50,
        from: 'Mumbai',
        to: 'Pune',
        date: date,
        rating: 3.8,
        reviewCount: 95,
        amenities: ['Water'],
        isAC: false,
        isSleeper: false,
      ),
      Bus(
        id: '4',
        operatorName: 'Volvo King',
        busNumber: 'RJ-04-GH-3456',
        busType: 'AC Sleeper',
        departureTime: '09:30 PM',
        arrivalTime: '05:30 AM',
        duration: '8h 00m',
        price: 1500.0,
        availableSeats: 8,
        totalSeats: 30,
        from: 'Delhi',
        to: 'Jaipur',
        date: date,
        rating: 4.7,
        reviewCount: 512,
        amenities: ['WiFi', 'Charging', 'Blanket', 'Water', 'Snacks', 'Entertainment'],
        isAC: true,
        isSleeper: true,
      ),
      Bus(
        id: '5',
        operatorName: 'RedBus Express',
        busNumber: 'RJ-05-IJ-7890',
        busType: 'AC Seater',
        departureTime: '07:00 AM',
        arrivalTime: '12:30 PM',
        duration: '5h 30m',
        price: 650.0,
        availableSeats: 18,
        totalSeats: 45,
        from: 'Delhi',
        to: 'Jaipur',
        date: date,
        rating: 4.0,
        reviewCount: 234,
        amenities: ['WiFi', 'Charging', 'Water'],
        isAC: true,
        isSleeper: false,
      ),
      Bus(
        id: '6',
        operatorName: 'SRS Travels',
        busNumber: 'KA-06-KL-2345',
        busType: 'AC Sleeper',
        departureTime: '10:00 PM',
        arrivalTime: '06:00 AM',
        duration: '8h 00m',
        price: 900.0,
        availableSeats: 12,
        totalSeats: 36,
        from: 'Bangalore',
        to: 'Chennai',
        date: date,
        rating: 4.3,
        reviewCount: 278,
        amenities: ['WiFi', 'Charging', 'Blanket', 'Water'],
        isAC: true,
        isSleeper: true,
      ),
      Bus(
        id: '7',
        operatorName: 'KPN Travels',
        busNumber: 'TN-07-MN-6789',
        busType: 'AC Seater',
        departureTime: '08:00 AM',
        arrivalTime: '02:00 PM',
        duration: '6h 00m',
        price: 550.0,
        availableSeats: 25,
        totalSeats: 50,
        from: 'Bangalore',
        to: 'Chennai',
        date: date,
        rating: 4.1,
        reviewCount: 156,
        amenities: ['Charging', 'Water', 'Snacks'],
        isAC: true,
        isSleeper: false,
      ),
      Bus(
        id: '8',
        operatorName: 'Paulo Travels',
        busNumber: 'MH-08-OP-1122',
        busType: 'Non-AC Seater',
        departureTime: '11:00 AM',
        arrivalTime: '03:30 PM',
        duration: '4h 30m',
        price: 350.0,
        availableSeats: 35,
        totalSeats: 50,
        from: 'Mumbai',
        to: 'Pune',
        date: date,
        rating: 3.5,
        reviewCount: 67,
        amenities: [],
        isAC: false,
        isSleeper: false,
      ),
      Bus(
        id: '9',
        operatorName: 'Shatabdi Travels',
        busNumber: 'UP-09-QR-3344',
        busType: 'AC Seater',
        departureTime: '02:00 PM',
        arrivalTime: '08:00 PM',
        duration: '6h 00m',
        price: 500.0,
        availableSeats: 20,
        totalSeats: 45,
        from: 'Delhi',
        to: 'Jaipur',
        date: date,
        rating: 3.9,
        reviewCount: 145,
        amenities: ['Charging', 'Water'],
        isAC: true,
        isSleeper: false,
      ),
      Bus(
        id: '10',
        operatorName: 'Greenline Travels',
        busNumber: 'GJ-10-ST-5566',
        busType: 'AC Sleeper',
        departureTime: '11:00 PM',
        arrivalTime: '07:00 AM',
        duration: '8h 00m',
        price: 1100.0,
        availableSeats: 5,
        totalSeats: 30,
        from: 'Hyderabad',
        to: 'Goa',
        date: date,
        rating: 4.6,
        reviewCount: 398,
        amenities: ['WiFi', 'Charging', 'Blanket', 'Water', 'Snacks', 'Entertainment'],
        isAC: true,
        isSleeper: true,
      ),
    ];

    return allBuses
        .where((bus) =>
            bus.from.trim().toLowerCase() == from.trim().toLowerCase() &&
            bus.to.trim().toLowerCase() == to.trim().toLowerCase())
        .toList();
  }

  static List<Seat> getSeatsForBus(String busId, double busPrice) {
    List<Seat> seats = [];
    int rows = 10;
    int columns = 5; // A B _ C D (2+2 with aisle)

    List<String> bookedSeatNumbers = [
      '1A', '2B', '3C', '4D', '5A', '7B', '8D', '10A', '6C', '3A',
    ];

    for (int i = 1; i <= rows; i++) {
      for (int j = 0; j < columns; j++) {
        String columnLetter = String.fromCharCode(65 + j); // A, B, C, D, E
        String seatNumber = '$i$columnLetter';

        bool isWindow = (j == 0 || j == 4);
        bool isAisle = (j == 1 || j == 2);

        SeatStatus status = bookedSeatNumbers.contains(seatNumber)
            ? SeatStatus.booked
            : SeatStatus.available;

        seats.add(
          Seat(
            seatNumber: seatNumber,
            status: status,
            price: busPrice,
            seatType: SeatType.seater,
            row: i,
            column: j,
            isWindow: isWindow,
            isAisle: isAisle,
          ),
        );
      }
    }

    return seats;
  }

  static List<Booking> get sampleBookings => [
    Booking(
      bookingId: 'BK20260520001',
      bus: Bus(
        id: '1',
        operatorName: 'Royal Cruiser',
        busNumber: 'RJ-01-AB-1234',
        busType: 'AC Sleeper',
        departureTime: '08:00 PM',
        arrivalTime: '06:00 AM',
        duration: '10h 00m',
        price: 1200.0,
        availableSeats: 15,
        totalSeats: 36,
        from: 'Mumbai',
        to: 'Pune',
        date: DateTime.now().add(const Duration(days: 3)),
        rating: 4.5,
        reviewCount: 342,
        amenities: ['WiFi', 'Charging', 'Blanket'],
        isAC: true,
        isSleeper: true,
      ),
      seatNumbers: ['3A', '3B'],
      passenger: Passenger(
        name: 'Vikas Choudhary',
        phoneNumber: '9876543210',
        email: 'vikas@email.com',
      ),
      totalPrice: 2400.0,
      status: BookingStatus.upcoming,
      bookingDate: DateTime.now().subtract(const Duration(days: 1)),
      paymentMethod: 'UPI',
    ),
    Booking(
      bookingId: 'BK20260515002',
      bus: Bus(
        id: '4',
        operatorName: 'Volvo King',
        busNumber: 'RJ-04-GH-3456',
        busType: 'AC Sleeper',
        departureTime: '09:30 PM',
        arrivalTime: '05:30 AM',
        duration: '8h 00m',
        price: 1500.0,
        availableSeats: 8,
        totalSeats: 30,
        from: 'Delhi',
        to: 'Jaipur',
        date: DateTime.now().subtract(const Duration(days: 5)),
        rating: 4.7,
        reviewCount: 512,
        amenities: ['WiFi', 'Charging', 'Blanket', 'Water'],
        isAC: true,
        isSleeper: true,
      ),
      seatNumbers: ['5C'],
      passenger: Passenger(
        name: 'Vikas Choudhary',
        phoneNumber: '9876543210',
        email: 'vikas@email.com',
      ),
      totalPrice: 1500.0,
      status: BookingStatus.completed,
      bookingDate: DateTime.now().subtract(const Duration(days: 8)),
      paymentMethod: 'Credit Card',
    ),
    Booking(
      bookingId: 'BK20260510003',
      bus: Bus(
        id: '6',
        operatorName: 'SRS Travels',
        busNumber: 'KA-06-KL-2345',
        busType: 'AC Sleeper',
        departureTime: '10:00 PM',
        arrivalTime: '06:00 AM',
        duration: '8h 00m',
        price: 900.0,
        availableSeats: 12,
        totalSeats: 36,
        from: 'Bangalore',
        to: 'Chennai',
        date: DateTime.now().subtract(const Duration(days: 10)),
        rating: 4.3,
        reviewCount: 278,
        amenities: ['WiFi', 'Charging'],
        isAC: true,
        isSleeper: true,
      ),
      seatNumbers: ['7A', '7B', '8A'],
      passenger: Passenger(
        name: 'Vikas Choudhary',
        phoneNumber: '9876543210',
        email: 'vikas@email.com',
      ),
      totalPrice: 2700.0,
      status: BookingStatus.cancelled,
      bookingDate: DateTime.now().subtract(const Duration(days: 15)),
      paymentMethod: 'Net Banking',
    ),
  ];

  static IconData getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'charging':
        return Icons.power;
      case 'blanket':
        return Icons.bed;
      case 'water':
        return Icons.water_drop;
      case 'snacks':
        return Icons.fastfood;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.check_circle_outline;
    }
  }
}
