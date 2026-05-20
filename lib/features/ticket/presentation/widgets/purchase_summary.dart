import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../shared/models/mrt_station.dart';

/// Purchase summary section — shows per-ticket price and total.
class PurchaseSummary extends StatelessWidget {
  final MrtStation? departure;
  final MrtStation? destination;
  final int passengers;

  const PurchaseSummary({
    super.key,
    required this.departure,
    required this.destination,
    required this.passengers,
  });

  int get _unitPrice =>
      (departure != null && destination != null) ? computePrice(departure!, destination!) : 3000;

  int get _total => _unitPrice * passengers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Purchase details',
            style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 14),
        _Row(
          label: 'Ticket Price',
          sub: departure != null && destination != null
              ? '(${departure!.name} → ${destination!.name})'
              : null,
          value: formatRp(_unitPrice),
        ),
        const SizedBox(height: 8),
        _Row(label: 'Total Tickets', value: '$passengers'),
        const SizedBox(height: 8),
        _Row(label: 'Ticket Subtotal', value: formatRp(_total)),
        const Divider(height: 24),
        _Row(
          label: 'Total Payment Estimation',
          value: formatRp(_total),
          highlight: true,
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String? sub;
  final String value;
  final bool highlight;

  const _Row({required this.label, required this.value, this.sub, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.body.copyWith(
                  fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
                  color: highlight ? AppColors.primaryGreen : AppColors.textPrimary,
                ),
              ),
              if (sub != null) Text(sub!, style: AppTextStyle.bodySmall),
            ],
          ),
        ),
        Text(
          value,
          style: AppTextStyle.body.copyWith(
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
            color: highlight ? AppColors.primaryGreen : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
