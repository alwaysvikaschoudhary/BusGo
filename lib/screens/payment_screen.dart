import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../models/bus.dart';
import '../models/passenger.dart';
import 'booking_confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Bus bus;
  final List<String> selectedSeats;
  final double totalPrice;
  final Passenger passenger;

  const PaymentScreen({
    super.key,
    required this.bus,
    required this.selectedSeats,
    required this.totalPrice,
    required this.passenger,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'UPI';
  bool _isProcessing = false;
  String _couponCode = '';
  double _discount = 0;

  double get _taxes => widget.totalPrice * 0.05;
  double get _convenienceFee => 25;
  double get _finalAmount => widget.totalPrice + _taxes + _convenienceFee - _discount;

  void _applyCoupon() {
    if (_couponCode.toLowerCase() == 'first50') {
      setState(() => _discount = 50);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🎉 Coupon applied! ₹50 off'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid coupon code'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _processPayment() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BookingConfirmationScreen(
              bus: widget.bus,
              selectedSeats: widget.selectedSeats,
              totalPrice: _finalAmount,
              passenger: widget.passenger,
              paymentMethod: _selectedMethod,
            ),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            Row(
              children: [
                _buildStep(context, '1', 'Seats', true),
                _buildStepLine(context, true),
                _buildStep(context, '2', 'Details', true),
                _buildStepLine(context, true),
                _buildStep(context, '3', 'Payment', true),
              ],
            ),
            const SizedBox(height: 32),

            // Payment Methods
            Text('Payment Method', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 16),
            ..._buildPaymentMethods(context),

            const SizedBox(height: 28),

            // Coupon
            Text('Have a Coupon?', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (v) => _couponCode = v,
                    decoration: InputDecoration(
                      hintText: 'Enter coupon code',
                      prefixIcon: const Icon(Icons.local_offer_outlined),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _applyCoupon,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 56),
                    ),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Try "FIRST50" for ₹50 off',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 28),

            // Price Breakdown
            Text('Price Breakdown', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: theme.dividerTheme.color?.withValues(alpha: 0.3) ?? Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  _buildPriceRow(context, 'Base Fare (${widget.selectedSeats.length} seats)',
                      '₹${widget.totalPrice.toStringAsFixed(0)}'),
                  _buildPriceRow(context, 'Taxes (5%)', '₹${_taxes.toStringAsFixed(0)}'),
                  _buildPriceRow(context, 'Convenience Fee', '₹${_convenienceFee.toStringAsFixed(0)}'),
                  if (_discount > 0)
                    _buildPriceRow(context, 'Coupon Discount', '-₹${_discount.toStringAsFixed(0)}',
                        isDiscount: true),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount', style: theme.textTheme.titleLarge),
                      Text(
                        '₹${_finalAmount.toStringAsFixed(0)}',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Security note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.shield_outlined, size: 20, color: AppColors.success),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '100% secure payment. Your data is encrypted.',
                      style: theme.textTheme.bodySmall?.copyWith(color: AppColors.success),
                    ),
                  ),
                ],
              ),
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
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              child: _isProcessing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        ),
                        SizedBox(width: 12),
                        Text('Processing...'),
                      ],
                    )
                  : Text('Pay ₹${_finalAmount.toStringAsFixed(0)}'),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPaymentMethods(BuildContext context) {
    final methods = [
      ('UPI', Icons.account_balance_wallet_outlined, 'Google Pay, PhonePe, Paytm'),
      ('Credit Card', Icons.credit_card_rounded, 'Visa, Mastercard, RuPay'),
      ('Net Banking', Icons.account_balance_outlined, 'All major banks'),
      ('Wallet', Icons.wallet_rounded, 'Paytm, Amazon Pay'),
    ];

    return methods.map((m) {
      final isSelected = _selectedMethod == m.$1;
      final theme = Theme.of(context);
      return GestureDetector(
        onTap: () => setState(() => _selectedMethod = m.$1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.dividerTheme.color?.withValues(alpha: 0.3) ?? Colors.grey.shade200,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary.withValues(alpha: 0.1)
                      : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  m.$2,
                  color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodySmall?.color,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.$1, style: theme.textTheme.titleMedium),
                    Text(m.$3, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodySmall?.color,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildPriceRow(BuildContext context, String label, String value, {bool isDiscount = false}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              color: isDiscount ? AppColors.success : null,
              fontWeight: isDiscount ? FontWeight.w700 : null,
            ),
          ),
        ],
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
}
