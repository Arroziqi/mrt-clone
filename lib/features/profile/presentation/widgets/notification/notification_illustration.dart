import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';


/// MRT mascot with notification bells illustration for the empty notification state.
class NotificationIllustration extends StatelessWidget {
  const NotificationIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main blue circle background
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              color: Color(0xFFDEEAF7),
              shape: BoxShape.circle,
            ),
          ),
          // MRT mascot body
          _MascotBody(),
          // Large bell top-left
          Positioned(
            top: 10,
            left: 10,
            child: _BellIcon(size: 52, withBadge: true),
          ),
          // Small bell top-right
          Positioned(
            top: 20,
            right: 20,
            child: _BellIcon(size: 34, withBadge: false),
          ),
          // Small bell bottom-left
          Positioned(
            bottom: 20,
            left: 24,
            child: _BellIcon(size: 30, withBadge: false),
          ),
        ],
      ),
    );
  }
}

class _MascotBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Eyes
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Eye(),
              const SizedBox(width: 12),
              _Eye(),
            ],
          ),
          const SizedBox(height: 6),
          // Mouth / nose dot
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFFD32F2F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 8),
          // MRT stripes
          Container(
            width: 50,
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(4),
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
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Color(0xFF111111),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _BellIcon extends StatelessWidget {
  final double size;
  final bool withBadge;
  const _BellIcon({required this.size, required this.withBadge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(Icons.notifications, color: const Color(0xFF90BEE0), size: size),
        if (withBadge)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFFDEEAF7),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '0',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
              ),
            ),
          ),
      ],
    );
  }
}
