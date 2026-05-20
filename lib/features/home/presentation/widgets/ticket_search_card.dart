import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';

/// The floating ticket search card that overlaps the blue header.
class TicketSearchCard extends StatelessWidget {
  const TicketSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(height: 28, width: 2, color: AppColors.border),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    _StationField(hint: 'Select Departure Station', label: 'From the Station'),
                    const SizedBox(height: 10),
                    _StationField(hint: 'Select Destination Station', label: 'To Station'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.swap_vert, color: AppColors.primaryBlue, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          AppButton(
            text: 'Buy Ticket',
            onPressed: () {},
            variant: AppButtonVariant.primaryGreen,
          ),
        ],
      ),
    );
  }
}

/// Single station selector field.
class _StationField extends StatelessWidget {
  final String label;
  final String hint;

  const _StationField({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyle.bodySmall.copyWith(fontSize: 10, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 2),
            Text(
              hint,
              style: AppTextStyle.bodySmall.copyWith(
                fontSize: 12,
                color: AppColors.disabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
