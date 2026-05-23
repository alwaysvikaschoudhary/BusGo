import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final List<String> filters;
  final Set<String> selectedFilters;
  final void Function(String) onToggle;

  const FilterBar({
    super.key,
    required this.filters,
    required this.selectedFilters,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilters.contains(filter);
          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (_) => onToggle(filter),
            showCheckmark: false,
            avatar: isSelected
                ? Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.primary)
                : null,
          );
        },
      ),
    );
  }
}
