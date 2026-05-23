import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/bus.dart';
import '../models/passenger.dart';
import '../widgets/common/app_text_field.dart';
import 'payment_screen.dart';

class PassengerDetailsScreen extends StatefulWidget {
  final Bus bus;
  final List<String> selectedSeats;
  final double totalPrice;

  const PassengerDetailsScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
  });

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedGender;
  bool _showSummary = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _proceed() {
    if (!_formKey.currentState!.validate()) return;

    final passenger = Passenger(
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      gender: _selectedGender,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          bus: widget.bus,
          selectedSeats: widget.selectedSeats,
          totalPrice: widget.totalPrice,
          passenger: passenger,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Passenger Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Row(
              children: [
                _buildStep(context, '1', 'Seats', true),
                _buildStepLine(context, true),
                _buildStep(context, '2', 'Details', true),
                _buildStepLine(context, false),
                _buildStep(context, '3', 'Payment', false),
              ],
            ),
            const SizedBox(height: 32),

            Text('Traveler Information', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Please enter details of the primary passenger',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 24),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    controller: _nameController,
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline_rounded,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Name is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _phoneController,
                    hintText: 'Phone Number',
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Phone is required';
                      if (v.trim().length < 10) return 'Enter a valid phone number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Gender selection
                  Row(
                    children: [
                      Text('Gender', style: theme.textTheme.titleSmall),
                      const SizedBox(width: 16),
                      ...[('Male', Icons.male), ('Female', Icons.female)].map(
                        (g) {
                          final isDark = theme.brightness == Brightness.dark;
                          final isSelected = _selectedGender == g.$1;
                          final labelColor = isSelected
                              ? (isDark ? Colors.white : theme.colorScheme.primary)
                              : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);
                          final chipBgColor = isSelected
                              ? (isDark ? const Color(0xFF1E3A5F) : AppColors.primaryContainer)
                              : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
                          final chipSide = isSelected
                              ? BorderSide.none
                              : BorderSide(color: isDark ? AppColors.dividerDark : AppColors.dividerLight);

                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(g.$2, size: 16, color: labelColor),
                                  const SizedBox(width: 4),
                                  Text(
                                    g.$1,
                                    style: TextStyle(
                                      color: labelColor,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              selected: isSelected,
                              backgroundColor: chipBgColor,
                              selectedColor: chipBgColor,
                              side: chipSide,
                              onSelected: (_) => setState(() => _selectedGender = g.$1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Booking summary — collapsible
            GestureDetector(
              onTap: () => setState(() => _showSummary = !_showSummary),
              child: Row(
                children: [
                  Text('Booking Summary', style: theme.textTheme.headlineSmall),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _showSummary ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            AnimatedCrossFade(
              firstChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  children: [
                    _buildRow(context, 'Bus', widget.bus.operatorName),
                    _buildRow(context, 'Route', '${widget.bus.from} → ${widget.bus.to}'),
                    _buildRow(context, 'Departure', widget.bus.departureTime),
                    _buildRow(context, 'Seats', widget.selectedSeats.join(', ')),
                    const Divider(height: 20),
                    _buildRow(context, 'Price per seat', widget.bus.formattedPrice),
                    _buildRow(context, 'Seats booked', '${widget.selectedSeats.length}'),
                    const Divider(height: 20),
                    _buildRow(
                      context,
                      'Total',
                      '₹${widget.totalPrice.toStringAsFixed(0)}',
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox.shrink(),
              crossFadeState: _showSummary
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(color: theme.dividerTheme.color ?? Colors.grey.shade200),
          ),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _proceed,
            child: const Text('Continue to Payment'),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String label, bool isActive) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: isActive ? Colors.white : theme.textTheme.bodySmall?.color,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: isActive ? theme.colorScheme.primary : null,
            fontWeight: isActive ? FontWeight.w600 : null,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(BuildContext context, bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16),
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).dividerTheme.color,
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value, {bool isHighlight = false}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          Flexible(
            child: Text(
              value,
              style: isHighlight
                  ? theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    )
                  : theme.textTheme.titleSmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
