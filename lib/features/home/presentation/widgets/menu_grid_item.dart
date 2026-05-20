import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// A single menu icon item in the MyMRTJ Menu grid.
class MenuGridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconBgColor;
  final bool isNew;

  const MenuGridItem({
    super.key,
    required this.icon,
    required this.label,
    this.iconBgColor = const Color(0xFFE8F0FB),
    this.isNew = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.primaryBlue, size: 30),
            ),
            if (isNew)
              Positioned(
                top: -6,
                right: -6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'New',
                    style: AppTextStyle.bodySmall.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(fontSize: 11, color: AppColors.textPrimary),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ],
    );
  }
}
