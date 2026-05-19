import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

class LifestyleSection extends StatelessWidget {
  const LifestyleSection({super.key});

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.title.copyWith(fontSize: 16),
          ),
          Text(
            'View All',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(double height, Color placeholderColor) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Container(
            width: height * 1.5,
            decoration: BoxDecoration(
              color: placeholderColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.image, color: placeholderColor, size: 40),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Lifestyle'),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Fulfill your lifestyle with MyMRTJ partners!',
            style: AppTextStyle.bodySmall,
          ),
        ),
        const SizedBox(height: 16),
        // Main Lifestyle Banner Placeholder
        Container(
          height: 160,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.local_activity, color: Colors.red, size: 48),
        ),
        
        const SizedBox(height: 32),
        _buildSectionHeader('Ticket Promo & Feeder'),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'For a more efficient and easier trip.',
            style: AppTextStyle.bodySmall,
          ),
        ),
        const SizedBox(height: 16),
        _buildHorizontalList(120, AppColors.primaryBlue),
        
        const SizedBox(height: 32),
        _buildSectionHeader('Lifestyle Promo'),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Enhance your lifestyle for the better.',
            style: AppTextStyle.bodySmall,
          ),
        ),
        const SizedBox(height: 16),
        _buildHorizontalList(120, Colors.brown),
      ],
    );
  }
}
