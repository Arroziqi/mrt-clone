import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../data/faq_data.dart';

/// A single expandable FAQ tile showing a question and its answer.
class FaqItemTile extends StatefulWidget {
  final FaqItem item;
  final bool initiallyExpanded;

  const FaqItemTile({
    super.key,
    required this.item,
    this.initiallyExpanded = false,
  });

  @override
  State<FaqItemTile> createState() => _FaqItemTileState();
}

class _FaqItemTileState extends State<FaqItemTile> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surface,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.question,
                style: AppTextStyle.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _expanded ? AppColors.primaryBlue : AppColors.textPrimary,
                ),
              ),
              if (_expanded) ...[
                const SizedBox(height: 10),
                Text(
                  widget.item.answer,
                  style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
