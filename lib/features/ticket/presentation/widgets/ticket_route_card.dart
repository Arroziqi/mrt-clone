import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../shared/models/mrt_station.dart';

/// The ticket-shaped route card at the top of the Buy Ticket page.
/// Shows departure / destination and handles station selection.
class TicketRouteCard extends StatelessWidget {
  final MrtStation? departure;
  final MrtStation? destination;
  final bool isRoundTrip;
  final VoidCallback onToggleRoundTrip;
  final VoidCallback onTapDeparture;
  final VoidCallback onTapDestination;
  final VoidCallback onSwap;

  const TicketRouteCard({
    super.key,
    required this.departure,
    required this.destination,
    required this.isRoundTrip,
    required this.onToggleRoundTrip,
    required this.onTapDeparture,
    required this.onTapDestination,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          // One-way / date row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text('One-way', style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                ),
                const SizedBox(width: 12),
                Text(
                  _todayLabel(),
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Stations row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Dot-line connector
                Column(
                  children: [
                    Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppColors.primaryGreen, shape: BoxShape.circle)),
                    Container(height: 28, width: 2, color: AppColors.border),
                    Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: onTapDeparture,
                        child: Text(
                          departure?.name ?? 'Select Departure Station',
                          style: AppTextStyle.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: departure != null ? AppColors.textPrimary : AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                      GestureDetector(
                        onTap: onTapDestination,
                        child: Text(
                          destination?.name ?? 'Select Destination Station',
                          style: AppTextStyle.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: destination != null ? AppColors.textPrimary : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Swap + Round-trip column
                Column(
                  children: [
                    GestureDetector(
                      onTap: onSwap,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.swap_vert, size: 18, color: AppColors.primaryBlue),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Switch(
                      value: isRoundTrip,
                      onChanged: (_) => onToggleRoundTrip(),
                      activeTrackColor: AppColors.primaryBlue,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text('Round-trip', style: AppTextStyle.bodySmall.copyWith(fontSize: 9)),
                  ],
                ),
              ],
            ),
          ),
          // Subscription upsell banner
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_offer, color: AppColors.accentYellow, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Save More with Ticket Subscription',
                      style: AppTextStyle.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right, color: Colors.white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _todayLabel() {
    final now = DateTime.now();
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
  }
}
