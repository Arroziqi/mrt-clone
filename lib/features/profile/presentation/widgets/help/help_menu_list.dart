import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../shared/widget/list_tile_item.dart';

/// FAQ and Contact Us menu items on the Help page.
class HelpMenuList extends StatelessWidget {
  const HelpMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTileItem(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryBlue, width: 1.5),
            ),
            child: const Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 20),
          ),
          title: 'FAQ',
          subtitle: 'Contains common questions about MyMRTJ',
          onTap: () => context.push('/faq'),
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryBlue, width: 1.5),
            ),
            child: const Icon(Icons.language, color: AppColors.primaryBlue, size: 20),
          ),
          title: 'Contact us',
          subtitle: 'Connect with the MyMRTJ team for any issues you may have',
          onTap: () {},
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
      ],
    );
  }
}
