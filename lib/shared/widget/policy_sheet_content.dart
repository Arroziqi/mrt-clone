import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_style.dart';

/// Represents a single section in a policy document.
class PolicySection {
  final String? heading;
  final String body;

  const PolicySection({this.heading, required this.body});
}

/// Reusable bottom-sheet-style layout for Privacy Policy / Terms pages.
class PolicySheetContent extends StatelessWidget {
  final String title;
  final List<PolicySection> sections;

  const PolicySheetContent({
    super.key,
    required this.title,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DragHandle(),
        _PolicyHeader(title: title),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            itemCount: sections.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, i) => _PolicySectionItem(section: sections[i]),
          ),
        ),
      ],
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class _PolicyHeader extends StatelessWidget {
  final String title;
  const _PolicyHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, size: 22),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _PolicySectionItem extends StatelessWidget {
  final PolicySection section;
  const _PolicySectionItem({required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.heading != null) ...[
          Text(
            section.heading!,
            style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
        ],
        Text(
          section.body,
          style: AppTextStyle.body.copyWith(color: AppColors.textSecondary, height: 1.6),
        ),
      ],
    );
  }
}
