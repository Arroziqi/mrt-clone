import 'package:flutter/material.dart';
import '../../config/theme/app_text_style.dart';
import '../../config/theme/app_colors.dart';

/// A reusable empty-state layout: illustration widget + heading + subtitle.
/// Pass any custom illustration as [illustration].
class EmptyStateView extends StatelessWidget {
  final Widget illustration;
  final String heading;
  final String subtitle;

  const EmptyStateView({
    super.key,
    required this.illustration,
    required this.heading,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          illustration,
          const SizedBox(height: 24),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: AppTextStyle.headline.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
