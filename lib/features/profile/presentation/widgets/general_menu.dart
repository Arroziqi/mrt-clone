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
          icon: Icons.language,
          title: 'Language',
          subtitle: 'Select the language / Choose Language',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          icon: Icons.help_outline,
          title: 'Help',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          icon: Icons.article_outlined,
          title: 'Terms and Conditions',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          icon: Icons.system_update_outlined,
          title: 'Application Version',
          subtitle: '4.16.0',
          trailing: const SizedBox.shrink(), // No chevron for version
        ),
      ],
    );
  }
}
