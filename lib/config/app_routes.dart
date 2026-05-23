import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String searchResults = '/search-results';
  static const String busDetails = '/bus-details';
  static const String seatSelection = '/seat-selection';
  static const String passengerDetails = '/passenger-details';
  static const String payment = '/payment';
  static const String bookingConfirmation = '/booking-confirmation';
  static const String bookingHistory = '/booking-history';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Default fallback — individual screen navigation is handled
    // via Navigator.push with MaterialPageRoute for passing arguments
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Route not found')),
      ),
    );
  }
}
