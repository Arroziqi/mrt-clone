import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';

/// Full-width blue illustrated banner for the Help page.
/// Shows "Butuh Bantuan?" heading and DINA description.
class HelpBanner extends StatelessWidget {
  const HelpBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryBlue,
      padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _DinaIllustration(),
          const SizedBox(width: 16),
          Expanded(child: _BannerText()),
        ],
      ),
    );
  }
}

class _BannerText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Butuh\nBantuan?',
            style: AppTextStyle.headline.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 28,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: AppTextStyle.bodySmall.copyWith(color: Colors.white70),
              children: const [
                TextSpan(text: 'Hubungi '),
                TextSpan(
                  text: 'DINA',
                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
                ),
                TextSpan(text: '\nDigital Intelligent Assistant\nMRT Jakarta'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DinaIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Face
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFFFDDB5),
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Eye(), const SizedBox(width: 10), _Eye(),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  width: 20, height: 3,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE91E63),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          // Uniform body
          Container(
            width: 80,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF1A237E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: const Center(
              child: Text('MRT', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Eye extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8, height: 8,
      decoration: const BoxDecoration(color: Color(0xFF333333), shape: BoxShape.circle),
    );
  }
}
