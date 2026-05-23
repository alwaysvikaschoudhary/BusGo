import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilters.contains(filter);

          final labelColor = isSelected
              ? (isDark ? Colors.white : theme.colorScheme.primary)
              : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

          final chipBgColor = isSelected
              ? (isDark ? const Color(0xFF1E3A5F) : AppColors.primaryContainer)
              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);

          final chipSide = isSelected
              ? BorderSide.none
              : BorderSide(color: isDark ? AppColors.dividerDark : AppColors.dividerLight);

          return FilterChip(
            label: Text(filter),
            labelStyle: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: labelColor,
            ),
            backgroundColor: chipBgColor,
            selectedColor: chipBgColor,
            side: chipSide,
            selected: isSelected,
            onSelected: (_) => onToggle(filter),
            showCheckmark: false,
            avatar: isSelected
                ? Icon(
                    Icons.check,
                    size: 16,
                    color: labelColor,
                  )
                : null,
          );
        },
      ),
    );
  }
}
