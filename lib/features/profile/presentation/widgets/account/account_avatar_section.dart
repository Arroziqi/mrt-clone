import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';


/// Avatar section at the top of the Account/Change Profile page.
/// Displays a circular MRT mascot avatar and a "Change photo" link below.
class AccountAvatarSection extends StatelessWidget {
  const AccountAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: Color(0xFFDEEAF7),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: _MascotAvatar(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Change photo',
            style: AppTextStyle.body.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _MascotAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDEEAF7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hair
          Container(
            width: 60,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFF111111),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          // Face
          Container(
            width: 60,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Dot(size: 8, color: const Color(0xFF111111)),
                    const SizedBox(width: 10),
                    _Dot(size: 8, color: const Color(0xFF111111)),
                  ],
                ),
                const SizedBox(height: 4),
                _Dot(size: 5, color: const Color(0xFFD32F2F)),
              ],
            ),
          ),
          // MRT stripe
          Container(
            width: 60,
            height: 14,
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final double size;
  final Color color;
  const _Dot({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
