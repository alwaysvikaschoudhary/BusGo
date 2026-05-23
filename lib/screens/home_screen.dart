import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../data/mock_data.dart';
import '../widgets/common/section_header.dart';
import '../widgets/home/featured_route_card.dart';
import '../widgets/home/quick_action_chip.dart';
import 'search_results_screen.dart';
import 'booking_history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String? _fromCity;
  String? _toCity;
  DateTime? _selectedDate;
  int _passengerCount = 1;


  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showCityPicker(bool isFrom) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        isFrom ? 'Select Origin' : 'Select Destination',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: MockData.cities.length,
                    itemBuilder: (context, index) {
                      final city = MockData.cities[index];
                      final isSelected = isFrom
                          ? city == _fromCity
                          : city == _toCity;
                      return ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        title: Text(
                          city,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.w600 : null,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                            : null,
                        onTap: () {
                          setState(() {
                            if (isFrom) {
                              _fromCity = city;
                            } else {
                              _toCity = city;
                            }
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _swapCities() {
    setState(() {
      final temp = _fromCity;
      _fromCity = _toCity;
      _toCity = temp;
    });
  }

  void _searchBuses() {
    if (_fromCity == null || _toCity == null || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all fields'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    if (_fromCity == _toCity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Origin and destination must be different'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(
          from: _fromCity!,
          to: _toCity!,
          date: _selectedDate!,
          passengers: _passengerCount,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeContent(),
          const BookingHistoryScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Traveler! 👋',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Where do you want to go?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.person_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Search Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.dividerTheme.color?.withValues(alpha: 0.3) ?? Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // From
                    _buildCitySelector(
                      label: 'From',
                      city: _fromCity,
                      icon: Icons.radio_button_checked,
                      iconColor: AppColors.success,
                      onTap: () => _showCityPicker(true),
                    ),

                    // Swap button + divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: GestureDetector(
                            onTap: _swapCities,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.swap_vert_rounded,
                                size: 20,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),

                    // To
                    _buildCitySelector(
                      label: 'To',
                      city: _toCity,
                      icon: Icons.location_on,
                      iconColor: AppColors.secondary,
                      onTap: () => _showCityPicker(false),
                    ),
                    const SizedBox(height: 16),

                    // Date + Passengers
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: _selectDate,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.dividerTheme.color ?? Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today_rounded,
                                      size: 18, color: theme.colorScheme.primary),
                                  const SizedBox(width: 10),
                                  Text(
                                    _selectedDate == null
                                        ? 'Date'
                                        : DateFormat('dd MMM').format(_selectedDate!),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: _selectedDate == null
                                          ? theme.textTheme.bodySmall?.color
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: theme.dividerTheme.color ?? Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person_outline_rounded,
                                    size: 18, color: theme.colorScheme.primary),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '$_passengerCount',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_passengerCount < 6) {
                                          setState(() => _passengerCount++);
                                        }
                                      },
                                      child: Icon(Icons.add_circle_outline,
                                          size: 20, color: theme.colorScheme.primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (_passengerCount > 1) {
                                          setState(() => _passengerCount--);
                                        }
                                      },
                                      child: Icon(Icons.remove_circle_outline,
                                          size: 20, color: theme.textTheme.bodySmall?.color),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _searchBuses,
                        icon: const Icon(Icons.search_rounded, size: 20),
                        label: const Text('Search Buses'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const SectionHeader(title: 'Quick Actions'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuickActionChip(
                    icon: Icons.receipt_long_rounded,
                    label: 'Bookings',
                    onTap: () => setState(() => _currentIndex = 1),
                  ),
                  QuickActionChip(
                    icon: Icons.local_offer_rounded,
                    label: 'Offers',
                    iconColor: AppColors.secondary,
                    onTap: () {},
                  ),
                  QuickActionChip(
                    icon: Icons.headset_mic_rounded,
                    label: 'Support',
                    iconColor: AppColors.tertiary,
                    onTap: () {},
                  ),
                  QuickActionChip(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    iconColor: AppColors.success,
                    onTap: () => setState(() => _currentIndex = 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Featured Routes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const SectionHeader(
                title: 'Popular Routes',
                actionLabel: 'See All',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                itemCount: MockData.featuredRoutes.length,
                itemBuilder: (context, index) {
                  final route = MockData.featuredRoutes[index];
                  return FeaturedRouteCard(
                    route: route,
                    onTap: () {
                      setState(() {
                        _fromCity = route.from;
                        _toCity = route.to;
                        _selectedDate = DateTime.now().add(const Duration(days: 1));
                      });
                      _searchBuses();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCitySelector({
    required String label,
    String? city,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.labelSmall),
                  const SizedBox(height: 2),
                  Text(
                    city ?? 'Select city',
                    style: city != null
                        ? theme.textTheme.titleLarge
                        : theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: theme.textTheme.bodySmall?.color),
          ],
        ),
      ),
    );
  }
}
