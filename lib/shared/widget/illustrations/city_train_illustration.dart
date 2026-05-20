import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

/// Animated MRT cityscape + train illustration.
/// Used as a bottom decoration on auth pages and ticket empty state.
class CityTrainIllustration extends StatefulWidget {
  final double height;
  const CityTrainIllustration({super.key, this.height = 100});

  @override
  State<CityTrainIllustration> createState() => _CityTrainIllustrationState();
}

class _CityTrainIllustrationState extends State<CityTrainIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _trainSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    )..repeat();
    _trainSlide = Tween<double>(begin: -1.2, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ClipRect(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Sky gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE8F4FD),
                    Color(0xFFDEEAF7),
                  ],
                ),
              ),
            ),
            // Buildings
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: _CityBuildings(),
            ),
            // Rail track
            Positioned(
              bottom: 18,
              left: 0,
              right: 0,
              child: Container(
                height: 3,
                color: AppColors.primaryBlue.withValues(alpha: 0.4),
              ),
            ),
            // Animated train
            AnimatedBuilder(
              animation: _trainSlide,
              builder: (context, child) {
                return Positioned(
                  bottom: 21,
                  left: 0,
                  right: 0,
                  child: FractionallySizedBox(
                    alignment: Alignment(_trainSlide.value, 0),
                    widthFactor: 0.35,
                    child: child!,
                  ),
                );
              },
              child: _Train(),
            ),
            // Ground
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 20,
                color: const Color(0xFFCBDCEE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CityBuildings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _Building(width: 22, height: 45, color: const Color(0xFFB0C4DE)),
        _Building(width: 16, height: 30, color: const Color(0xFF90B4D2)),
        _Building(width: 28, height: 60, color: const Color(0xFF8AACC8)),
        _Building(width: 18, height: 38, color: const Color(0xFFA8C4D8)),
        _Building(width: 24, height: 52, color: const Color(0xFF7FA8C4)),
        _Building(width: 14, height: 28, color: const Color(0xFFB8D0E4)),
        _Building(width: 20, height: 42, color: const Color(0xFF9ABCD6)),
        _Building(width: 26, height: 55, color: const Color(0xFF88B4CC)),
        _Building(width: 15, height: 32, color: const Color(0xFFA4C0D8)),
        _Building(width: 22, height: 48, color: const Color(0xFF94B8D0)),
      ],
    );
  }
}

class _Building extends StatelessWidget {
  final double width, height;
  final Color color;
  const _Building({required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          // Windows
          ...List.generate((height ~/ 12).clamp(1, 5), (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Window(),
                  if (width > 18) ...[const SizedBox(width: 2), _Window()],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Window extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class _Train extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Front
          Container(
            width: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF003D8F),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
            ),
            child: const Center(
              child: Icon(Icons.circle, size: 4, color: AppColors.accentYellow),
            ),
          ),
          // Windows
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (i) {
                return Container(
                  width: 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBBDEFB),
                    borderRadius: BorderRadius.circular(1),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
