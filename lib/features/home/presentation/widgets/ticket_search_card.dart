import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';

class TicketSearchCard extends StatelessWidget {
  const TicketSearchCard({super.key});

  Widget _buildStationInput(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            'Select ${label.split(' ')[0]} Station',
            style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.near_me, color: AppColors.primaryBlue, size: 16),
              const SizedBox(width: 8),
              Text(
                'You are 1 km from ASEAN station',
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryBlue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primaryGreen, size: 20),
                  Container(height: 30, width: 2, color: AppColors.border),
                  const Icon(Icons.location_on, color: Colors.red, size: 20),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    _buildStationInput('From the Station'),
                    const SizedBox(height: 16),
                    _buildStationInput('To Station'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.swap_vert, color: AppColors.primaryBlue),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'Buy Ticket',
            onPressed: () {}, // Navigate to buy ticket or switch tab
            variant: AppButtonVariant.primaryGreen,
          ),
        ],
      ),
    );
  }
}
