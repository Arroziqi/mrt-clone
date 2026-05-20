import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';

/// Model for a payment provider entry.
class PaymentProvider {
  final String name;
  final Color iconColor;
  final String iconLetter;

  const PaymentProvider({
    required this.name,
    required this.iconColor,
    required this.iconLetter,
  });
}

/// Single payment provider row card with a toggle switch.
class PaymentProviderTile extends StatefulWidget {
  final PaymentProvider provider;

  const PaymentProviderTile({super.key, required this.provider});

  @override
  State<PaymentProviderTile> createState() => _PaymentProviderTileState();
}

class _PaymentProviderTileState extends State<PaymentProviderTile> {
  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surface,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: _ProviderIcon(
          letter: widget.provider.iconLetter,
          color: widget.provider.iconColor,
        ),
        title: Text(
          widget.provider.name,
          style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          _connected ? 'Connected' : 'Not connected',
          style: AppTextStyle.bodySmall.copyWith(
            color: _connected ? AppColors.primaryGreen : AppColors.textSecondary,
          ),
        ),
        trailing: Switch(
          value: _connected,
          onChanged: (val) => setState(() => _connected = val),
          activeTrackColor: AppColors.primaryBlue,
          activeThumbColor: Colors.white,
        ),
      ),
    );
  }
}

class _ProviderIcon extends StatelessWidget {
  final String letter;
  final Color color;
  const _ProviderIcon({required this.letter, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
