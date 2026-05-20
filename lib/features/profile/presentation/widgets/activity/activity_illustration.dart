import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';

/// MRT mascot with clock illustration for the Activity History empty state.
class ActivityIllustration extends StatelessWidget {
  const ActivityIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circle background
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFFDEEAF7),
              shape: BoxShape.circle,
            ),
          ),
          // Clock
          Positioned(
            bottom: 20,
            child: _ClockWidget(),
          ),
          // Mascot body
          Positioned(
            top: 20,
            child: _Mascot(),
          ),
          // Warning triangle top-right
          Positioned(
            top: 15,
            right: 15,
            child: _WarningTriangle(),
          ),
          // Small triangles bottom
          Positioned(
            bottom: 10,
            left: 20,
            child: _SmallTriangle(),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: _SmallTriangle(),
          ),
        ],
      ),
    );
  }
}

class _ClockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryBlue, width: 3),
        color: const Color(0xFFDEEAF7),
      ),
      child: const Center(
        child: Icon(Icons.access_time, color: AppColors.primaryBlue, size: 40),
      ),
    );
  }
}

class _Mascot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Dot(const Color(0xFF111111), 6),
              const SizedBox(width: 8),
              _Dot(const Color(0xFF111111), 6),
            ],
          ),
          const SizedBox(height: 4),
          _Dot(const Color(0xFFD32F2F), 4),
          const SizedBox(height: 4),
          Container(width: 32, height: 8, color: AppColors.primaryBlue),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;
  const _Dot(this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _WarningTriangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.warning_amber, color: AppColors.primaryBlue, size: 20),
    );
  }
}

class _SmallTriangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.change_history, color: AppColors.primaryBlue, size: 18);
  }
}
