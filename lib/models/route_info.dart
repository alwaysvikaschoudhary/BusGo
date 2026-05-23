import 'package:flutter/material.dart';

class RouteInfo {
  final String from;
  final String to;
  final String distance;
  final String estimatedTime;
  final int startingPrice;
  final IconData icon;
  final List<Color> gradientColors;

  RouteInfo({
    required this.from,
    required this.to,
    required this.distance,
    required this.estimatedTime,
    required this.startingPrice,
    this.icon = Icons.directions_bus,
    this.gradientColors = const [Color(0xFF1A73E8), Color(0xFF6C63FF)],
  });

  String get routeName => '$from → $to';
  String get formattedPrice => 'From ₹$startingPrice';
}
