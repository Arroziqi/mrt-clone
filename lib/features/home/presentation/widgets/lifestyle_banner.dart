import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// The big lifestyle/events tab-banner shown below MyMRTJ Menu.
/// Displays tabbed categories (Events, Banking, Entertainment) with a promo visual.
class LifestyleBanner extends StatefulWidget {
  const LifestyleBanner({super.key});

  @override
  State<LifestyleBanner> createState() => _LifestyleBannerState();
}

class _LifestyleBannerState extends State<LifestyleBanner> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Events', 'Banking', 'Entertainment'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.red[700],
        gradient: const LinearGradient(
          colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final isSelected = i == _selectedTab;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTab = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      _tabs[i],
                      style: AppTextStyle.bodySmall.copyWith(
                        color: isSelected ? Colors.red[700] : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Banner content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#JelajahiJakarta',
                        style: AppTextStyle.title.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Datang ke Berbagai Acara Seru Dengan Kemudahan Pembelian Tiket di Aplikasi MyMRTJ',
                        style: AppTextStyle.bodySmall.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Selengkapnya →',
                          style: AppTextStyle.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Phone mockup placeholder
                Container(
                  width: 90,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.smartphone, color: Colors.white, size: 48),
                ),
              ],
            ),
          ),
          // Partner logos row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Text(
                  'View products and services from:',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
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
