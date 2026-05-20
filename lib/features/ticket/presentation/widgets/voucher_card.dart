import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';

/// Voucher code input card.
class VoucherCard extends StatelessWidget {
  final TextEditingController controller;

  const VoucherCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD0E2F4)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Voucher Code',
              style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'E.g., BWA123KCA',
              hintStyle: AppTextStyle.bodySmall.copyWith(color: AppColors.disabled),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            style: AppTextStyle.body,
          ),
          const SizedBox(height: 6),
          Text(
            'Use the voucher code to get a discount',
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }
}
