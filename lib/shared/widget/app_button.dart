import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_style.dart';

enum AppButtonVariant { primaryBlue, primaryGreen, lightBlue, lightGreen, logout, social }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final String? iconPath;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primaryBlue,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.primaryBlue:
        bgColor = AppColors.primaryBlue;
        textColor = AppColors.surface;
        break;
      case AppButtonVariant.primaryGreen:
        bgColor = AppColors.primaryGreen;
        textColor = AppColors.surface;
        break;
      case AppButtonVariant.lightBlue:
        bgColor = const Color(0xFFEAF2F9); // Light blue from design
        textColor = AppColors.primaryBlue;
        break;
      case AppButtonVariant.lightGreen:
        bgColor = const Color(0xFFE8F5E9); // Light green from design
        textColor = AppColors.primaryGreen;
        break;
      case AppButtonVariant.logout:
        bgColor = AppColors.logoutBg;
        textColor = AppColors.logoutText;
        break;
      case AppButtonVariant.social:
        bgColor = AppColors.surface;
        textColor = AppColors.textPrimary;
        borderSide = const BorderSide(color: AppColors.border);
        break;
    }

    // Handle disabled state
    if (onPressed == null) {
      bgColor = AppColors.border;
      textColor = AppColors.textSecondary;
      borderSide = BorderSide.none;
    }

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide,
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              // Google icon
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.g_mobiledata, color: Color(0xFFDB4437), size: 20),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppTextStyle.button.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
