import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widget/list_tile_item.dart';

class GeneralMenu extends StatelessWidget {
  const GeneralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Text(
            'General',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),
        ListTileItem(
          leading: const Icon(Icons.language, color: AppColors.primaryBlue, size: 28),
          title: 'Language',
          subtitle: 'Select the language / Choose Language',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.help_outline, color: AppColors.primaryBlue, size: 28),
          title: 'Help',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.article_outlined, color: AppColors.primaryBlue, size: 28),
          title: 'Terms and Conditions',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primaryBlue, size: 28),
          title: 'Privacy Policy',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.system_update_outlined, color: AppColors.primaryBlue, size: 28),
          title: 'Application Version',
          subtitle: '4.16.0',
          trailing: const SizedBox.shrink(), // No chevron for version
        ),
      ],
    );
  }
}
