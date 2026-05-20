import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// Blue curved header with greeting text and notification icon.
/// Accepts a [child] widget that will be overlaid below the curve.
class HomeHeader extends StatelessWidget {
  final Widget child;

  const HomeHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Blue background
        Container(
          height: 175,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome MRT Friends',
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Where are we going today?',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.surface.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Location chip
                  Row(
                    children: [
                      const Icon(Icons.near_me_outlined, color: AppColors.surface, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'You are 1 km from ASEAN station',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.surface.withValues(alpha: 0.85),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_outlined, color: AppColors.surface, size: 22),
              ),
            ],
          ),
        ),
        // Overlapping ticket search card
        Positioned(
          top: 135,
          left: 16,
          right: 16,
          child: child,
        ),
      ],
    );
  }
}
