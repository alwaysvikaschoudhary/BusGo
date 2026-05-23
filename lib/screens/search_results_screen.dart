import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../models/bus.dart';
import '../widgets/search/bus_card.dart';
import '../widgets/search/filter_bar.dart';
import '../widgets/common/loading_shimmer.dart';
import '../widgets/common/empty_state.dart';
import 'bus_details_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String from;
  final String to;
  final DateTime date;
  final int passengers;

  const SearchResultsScreen({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    this.passengers = 1,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  List<Bus> _buses = [];
  List<Bus> _filteredBuses = [];
  bool _isLoading = true;
  final Set<String> _activeFilters = {};
  String _sortBy = 'price';

  final List<String> _filters = [
    'AC',
    'Non-AC',
    'Sleeper',
    'Seater',
    '4★+',
    'Under ₹500',
  ];

  @override
  void initState() {
    super.initState();
    _loadBuses();
  }

  void _loadBuses() {
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _buses = MockData.getBusesForSearch(widget.from, widget.to, widget.date);
          _filteredBuses = List.from(_buses);
          _isLoading = false;
        });
      }
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredBuses = _buses.where((bus) {
        if (_activeFilters.contains('AC') && !bus.isAC) return false;
        if (_activeFilters.contains('Non-AC') && bus.isAC) return false;
        if (_activeFilters.contains('Sleeper') && !bus.isSleeper) return false;
        if (_activeFilters.contains('Seater') && bus.isSleeper) return false;
        if (_activeFilters.contains('4★+') && bus.rating < 4.0) return false;
        if (_activeFilters.contains('Under ₹500') && bus.price >= 500) return false;
        return true;
      }).toList();

      _sortBuses();
    });
  }

  void _sortBuses() {
    switch (_sortBy) {
      case 'price':
        _filteredBuses.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'rating':
        _filteredBuses.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'departure':
        _filteredBuses.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
    }
  }

  void _toggleFilter(String filter) {
    if (_activeFilters.contains(filter)) {
      _activeFilters.remove(filter);
    } else {
      // Remove conflicting filters
      if (filter == 'AC') _activeFilters.remove('Non-AC');
      if (filter == 'Non-AC') _activeFilters.remove('AC');
      if (filter == 'Sleeper') _activeFilters.remove('Seater');
      if (filter == 'Seater') _activeFilters.remove('Sleeper');
      _activeFilters.add(filter);
    }
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.from} → ${widget.to}',
              style: theme.appBarTheme.titleTextStyle?.copyWith(fontSize: 16),
            ),
            Text(
              '${DateFormat('EEE, dd MMM').format(widget.date)} · ${widget.passengers} passenger${widget.passengers > 1 ? 's' : ''}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort_rounded),
            onSelected: (value) {
              setState(() {
                _sortBy = value;
                _sortBuses();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'price',
                child: Row(
                  children: [
                    if (_sortBy == 'price')
                      Icon(Icons.check, size: 18, color: theme.colorScheme.primary),
                    if (_sortBy == 'price') const SizedBox(width: 8),
                    const Text('Price: Low to High'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'rating',
                child: Row(
                  children: [
                    if (_sortBy == 'rating')
                      Icon(Icons.check, size: 18, color: theme.colorScheme.primary),
                    if (_sortBy == 'rating') const SizedBox(width: 8),
                    const Text('Rating: High to Low'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'departure',
                child: Row(
                  children: [
                    if (_sortBy == 'departure')
                      Icon(Icons.check, size: 18, color: theme.colorScheme.primary),
                    if (_sortBy == 'departure') const SizedBox(width: 8),
                    const Text('Departure: Earliest'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: FilterBar(
              filters: _filters,
              selectedFilters: _activeFilters,
              onToggle: _toggleFilter,
            ),
          ),
          const Divider(height: 1),

          // Results
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _filteredBuses.isEmpty
                    ? EmptyState(
                        icon: Icons.directions_bus_outlined,
                        title: 'No Buses Found',
                        subtitle: 'Try adjusting your filters or search for a different route.',
                        actionLabel: 'Clear Filters',
                        onAction: () {
                          setState(() {
                            _activeFilters.clear();
                            _filteredBuses = List.from(_buses);
                            _sortBuses();
                          });
                        },
                      )
                    : _buildBusList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 4,
      itemBuilder: (_, __) => const BusCardShimmer(),
    );
  }

  Widget _buildBusList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      itemCount: _filteredBuses.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${_filteredBuses.length} bus${_filteredBuses.length != 1 ? 'es' : ''} found',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        }
        final bus = _filteredBuses[index - 1];
        return BusCard(
          bus: bus,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BusDetailsScreen(bus: bus),
              ),
            );
          },
        );
      },
    );
  }
}
