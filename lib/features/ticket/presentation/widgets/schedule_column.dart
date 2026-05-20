import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';

/// One column in the schedule view — shows a colored "next train" header
/// and a list of upcoming times below.
class ScheduleColumn extends StatelessWidget {
  final String direction;
  final String nextTime;
  final List<String> upcoming;
  final Color headerColor;
  final Color headerColorEnd;

  const ScheduleColumn({
    super.key,
    required this.direction,
    required this.nextTime,
    required this.upcoming,
    required this.headerColor,
    this.headerColorEnd = const Color(0xFF0D47A1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [headerColor, headerColorEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.train, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        direction,
                        style: AppTextStyle.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  nextTime,
                  style: AppTextStyle.headline.copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 36),
                ),
              ],
            ),
          ),
          // Upcoming times
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text('Next departure',
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
          ),
          ...upcoming.map((t) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  t,
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
