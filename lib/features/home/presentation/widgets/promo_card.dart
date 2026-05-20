import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// A horizontally scrollable promo card used in Ticket Promo & Feeder
/// and Lifestyle Promo sections.
class PromoCard extends StatelessWidget {
  final String title;
  final String badge;
  final Color badgeColor;
  final Color bgColor;
  final Color bgColorEnd;

  const PromoCard({
    super.key,
    required this.title,
    required this.badge,
    this.badgeColor = Colors.white,
    this.bgColor = const Color(0xFF1565C0),
    this.bgColorEnd = const Color(0xFF0D47A1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [bgColor, bgColorEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'MyMRTJ',
              style: AppTextStyle.bodySmall.copyWith(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyle.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 11,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Text(
            badge,
            style: AppTextStyle.headline.copyWith(
              color: badgeColor,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Klik Di Sini',
                style: AppTextStyle.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
