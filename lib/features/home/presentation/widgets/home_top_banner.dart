import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

/// A horizontally auto-scrolling banner shown at the top of the home feed,
/// matching the "HEMAT MAKSIMAL" promo banner in the design.
class HomeTopBanner extends StatefulWidget {
  const HomeTopBanner({super.key});

  @override
  State<HomeTopBanner> createState() => _HomeTopBannerState();
}

class _HomeTopBannerState extends State<HomeTopBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_BannerData> _banners = const [
    _BannerData(
      title: 'HEMAT\nMAKSIMAL',
      subtitle: 'Beli Tiket MRT & Dapatkan Cashback',
      badge: '144rb',
      bgColor: Color(0xFF0D47A1),
      accentColor: AppColors.accentYellow,
    ),
    _BannerData(
      title: 'PROMO\nSPESIAL',
      subtitle: 'Naik MRT Jakarta, Dapat Cashback',
      badge: '50%',
      bgColor: Color(0xFF1B5E20),
      accentColor: Colors.white,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _controller,
            itemCount: _banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, i) => _BannerCard(data: _banners[i]),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == _currentPage ? 16 : 6,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: i == _currentPage ? AppColors.primaryBlue : AppColors.border,
            ),
          )),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final _BannerData data;
  const _BannerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [data.bgColor, Color.lerp(data.bgColor, Colors.black, 0.2)!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: AppTextStyle.title.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.subtitle,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: data.accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: data.accentColor.withValues(alpha: 0.4)),
            ),
            child: Text(
              data.badge,
              style: AppTextStyle.headline.copyWith(
                color: data.accentColor,
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerData {
  final String title, subtitle, badge;
  final Color bgColor, accentColor;
  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.bgColor,
    required this.accentColor,
  });
}
