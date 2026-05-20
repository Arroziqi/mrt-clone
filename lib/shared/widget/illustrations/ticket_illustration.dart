import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

/// Animated MRT ticket illustration for the Ticket empty state.
/// Shows a stylized train ticket with QR code area, floating gently.
class TicketIllustration extends StatefulWidget {
  const TicketIllustration({super.key});

  @override
  State<TicketIllustration> createState() => _TicketIllustrationState();
}

class _TicketIllustrationState extends State<TicketIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;
  late final Animation<double> _rotate;

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
    _rotate = Tween<double>(begin: -0.02, end: 0.02).animate(
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
      width: 220,
      height: 220,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _float.value),
            child: Transform.rotate(
              angle: _rotate.value,
              child: child,
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Soft circle background
            Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFFDEEAF7),
                shape: BoxShape.circle,
              ),
            ),
            // Ticket card
            Positioned(
              top: 30,
              child: _TicketCard(),
            ),
            // Mascot on top-right
            Positioned(
              top: 15,
              right: 20,
              child: _MiniMascot(),
            ),
            // Decorative dots
            const Positioned(
              bottom: 25,
              left: 20,
              child: _DecorativeDot(size: 8, color: AppColors.primaryBlue),
            ),
            const Positioned(
              top: 20,
              left: 30,
              child: _DecorativeDot(size: 6, color: AppColors.primaryGreen),
            ),
            const Positioned(
              bottom: 35,
              right: 25,
              child: _DecorativeDot(size: 10, color: AppColors.accentYellow),
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
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Blue header strip
          Container(
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: const Center(
              child: Text(
                'MRT JAKARTA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Route row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StationDot(AppColors.primaryBlue),
                Expanded(
                  child: Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  ),
                ),
                const Icon(Icons.train, size: 14, color: AppColors.primaryBlue),
                Expanded(
                  child: Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  ),
                ),
                _StationDot(AppColors.primaryGreen),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Dashed divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: List.generate(
                20,
                (i) => Expanded(
                  child: Container(
                    height: 1,
                    color: i.isEven ? AppColors.border : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // QR code area
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(4),
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(16, (i) {
                final fill = (i + i ~/ 4) % 3 != 0;
                return Container(
                  decoration: BoxDecoration(
                    color: fill ? Colors.black87 : Colors.transparent,
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

class _StationDot extends StatelessWidget {
  final Color color;
  const _StationDot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4),
        ],
      ),
    );
  }
}

class _MiniMascot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 5, height: 5,
                decoration: const BoxDecoration(color: Color(0xFF111111), shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Container(
                width: 5, height: 5,
                decoration: const BoxDecoration(color: Color(0xFF111111), shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Container(width: 22, height: 6, color: AppColors.primaryBlue),
        ],
      ),
    );
  }
}

class _DecorativeDot extends StatelessWidget {
  final double size;
  final Color color;
  const _DecorativeDot({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.4),
        shape: BoxShape.circle,
      ),
    );
  }
}
