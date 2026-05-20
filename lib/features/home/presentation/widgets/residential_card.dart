import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// A card showing a residential unit with image, name, and provider.
class ResidentialCard extends StatelessWidget {
  final String name;
  final String provider;
  final Color placeholderColor;

  const ResidentialCard({
    super.key,
    required this.name,
    required this.provider,
    this.placeholderColor = const Color(0xFF607D8B),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 100,
              color: placeholderColor,
              alignment: Alignment.center,
              child: Icon(Icons.bed, color: Colors.white.withValues(alpha: 0.7), size: 36),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 11,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  provider,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primaryGreen,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
