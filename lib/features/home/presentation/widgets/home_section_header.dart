import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// Reusable section header with a title and optional "View All" button.
class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onViewAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.body.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),
              if (onViewAll != null)
                GestureDetector(
                  onTap: onViewAll,
                  child: Text(
                    'View All',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: AppTextStyle.bodySmall),
          ],
        ],
      ),
    );
  }
}
