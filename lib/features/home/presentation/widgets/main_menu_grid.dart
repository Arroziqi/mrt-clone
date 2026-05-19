import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

class MainMenuGrid extends StatelessWidget {
  const MainMenuGrid({super.key});

  Widget _buildItem(IconData icon, String label, {bool isNew = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, color: AppColors.primaryBlue, size: 28),
            ),
            if (isNew)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'New',
                    style: AppTextStyle.bodySmall.copyWith(
                      fontSize: 10,
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
          style: AppTextStyle.bodySmall.copyWith(fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MyMRTJ Menu',
            style: AppTextStyle.title.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Enjoy our various features for your mobility & your lifestyle!',
            style: AppTextStyle.bodySmall,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
            children: [
              _buildItem(Icons.pedal_bike, 'eRide\nCharter', isNew: true),
              _buildItem(Icons.directions_car, 'eBike', isNew: true),
              _buildItem(Icons.schedule, 'Schedule'),
              _buildItem(Icons.store, 'Station'),
              _buildItem(Icons.local_activity, 'Event'),
              _buildItem(Icons.local_offer, 'Voucher\nDiscount'),
              _buildItem(Icons.podcasts, 'Podcast'),
              _buildItem(Icons.article, 'News'),
            ],
          ),
        ],
      ),
    );
  }
}
