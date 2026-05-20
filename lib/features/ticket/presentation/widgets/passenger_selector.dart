import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';

/// Horizontal number-picker for passenger count (1–5).
class PassengerSelector extends StatelessWidget {
  final int count;
  final ValueChanged<int> onChanged;

  const PassengerSelector({super.key, required this.count, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Number of Passengers',
            style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 12),
        Row(
          children: List.generate(5, (i) {
            final n = i + 1;
            final selected = count == n;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(n),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: EdgeInsets.only(right: i < 4 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primaryGreen : AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected ? AppColors.primaryGreen : AppColors.border,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$n',
                    style: AppTextStyle.body.copyWith(
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
