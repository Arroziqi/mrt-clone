import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

/// Animated subscription illustration for the Subscription empty state.
/// Shows a gift box / subscription card with floating animation.
class SubscriptionIllustration extends StatefulWidget {
  const SubscriptionIllustration({super.key});

  @override
  State<SubscriptionIllustration> createState() => _SubscriptionIllustrationState();
}

class _SubscriptionIllustrationState extends State<SubscriptionIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _float = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
      width: 200,
      height: 200,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _float.value),
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circle bg
            Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0xFFDEEAF7),
                shape: BoxShape.circle,
              ),
            ),
            // Gift box / card
            _SubscriptionCard(),
            // Stars / sparkles
            const Positioned(
              top: 10,
              right: 15,
              child: _Sparkle(size: 16),
            ),
            const Positioned(
              top: 25,
              left: 12,
              child: _Sparkle(size: 12),
            ),
            const Positioned(
              bottom: 20,
              right: 25,
              child: _Sparkle(size: 10),
            ),
            // Mascot
            Positioned(
              bottom: 15,
              left: 15,
              child: _SmallMascot(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Calendar / card icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.card_membership_rounded,
              color: AppColors.primaryBlue,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          // Subscription lines
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  final double size;
  const _Sparkle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.auto_awesome,
      size: size,
      color: AppColors.accentYellow,
    );
  }
}

class _SmallMascot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 4, height: 4,
                decoration: const BoxDecoration(color: Color(0xFF111111), shape: BoxShape.circle),
              ),
              const SizedBox(width: 5),
              Container(
                width: 4, height: 4,
                decoration: const BoxDecoration(color: Color(0xFF111111), shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Container(width: 18, height: 5, color: AppColors.primaryBlue),
        ],
      ),
    );
  }
}
