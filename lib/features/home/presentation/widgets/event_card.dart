import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// A card showing an event with a colored image placeholder and title.
class EventCard extends StatelessWidget {
  final String title;
  final String category;
  final Color placeholderColor;
  final IconData icon;

  const EventCard({
    super.key,
    required this.title,
    required this.category,
    this.placeholderColor = const Color(0xFF1A1A2E),
    this.icon = Icons.music_note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
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
              height: 110,
              color: placeholderColor,
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primaryGreen,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
