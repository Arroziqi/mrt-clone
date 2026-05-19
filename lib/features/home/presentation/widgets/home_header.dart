import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

class HomeHeader extends StatelessWidget {
  final Widget child; // The TicketSearchCard will be placed here over the curve

  const HomeHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Blue Background with curved bottom
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
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
                    style: AppTextStyle.title.copyWith(color: AppColors.surface),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Where are we going today?',
                    style: AppTextStyle.bodySmall.copyWith(color: AppColors.surface.withOpacity(0.8)),
                  ),
                ],
              ),
              const Icon(Icons.notifications, color: AppColors.surface),
            ],
          ),
        ),
        
        // Ticket Search Card overlaid
        Positioned(
          top: 130, // Adjust to overlap correctly
          left: 24,
          right: 24,
          child: child,
        ),
      ],
    );
  }
}
