import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

/// Animated ticket illustration for the Ticket empty state.
/// Shows a floating QR-code-style ticket card with sparkles.
class TicketIllustration extends StatefulWidget {
  const TicketIllustration({super.key});

  @override
  State<TicketIllustration> createState() => _TicketIllustrationState();
}

class _TicketIllustrationState extends State<TicketIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _float = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.03).animate(
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
            // Circle background
            Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0xFFDEEAF7),
                shape: BoxShape.circle,
              ),
            ),
            // Ticket card
            _TicketCard(),
            // Sparkles
            const Positioned(
              top: 12,
              right: 18,
              child: _Sparkle(size: 16),
            ),
            const Positioned(
              top: 28,
              left: 14,
              child: _Sparkle(size: 11),
            ),
            const Positioned(
              bottom: 22,
              right: 28,
              child: _Sparkle(size: 9),
            ),
            // Small train icon badge
            Positioned(
              bottom: 18,
              left: 18,
              child: _TrainBadge(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.13),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top bar (ticket header strip)
          Container(
            width: 80,
            height: 8,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.primaryGreen],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 10),
          // QR-like grid
          SizedBox(
            width: 52,
            height: 52,
            child: GridView.count(
              crossAxisCount: 5,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(25, (i) {
                final filled = [
                  0, 1, 2, 3, 4,
                  5, 9,
                  10, 11, 12,
                  13, 17,
                  20, 21, 22, 23, 24,
                  6, 16,
                  8, 18,
                ].contains(i);
                return Container(
                  decoration: BoxDecoration(
                    color: filled
                        ? AppColors.primaryBlue
                        : const Color(0xFFF0F4F8),
                    borderRadius: BorderRadius.circular(1),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          // Dashed separator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(7, (i) => Container(
              width: 6, height: 1.5,
              margin: const EdgeInsets.only(right: 2),
              color: AppColors.border,
            )),
          ),
          const SizedBox(height: 6),
          // Station label lines
          Container(
            width: 56,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.25),
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
    return Icon(Icons.auto_awesome, size: size, color: AppColors.accentYellow);
  }
}

class _TrainBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.train_rounded, color: Colors.white, size: 18),
    );
  }
}
