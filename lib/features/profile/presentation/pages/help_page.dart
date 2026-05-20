import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../widgets/help/help_banner.dart';
import '../widgets/help/help_menu_list.dart';

/// Help page.
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Help'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Column(
        children: const [
          HelpBanner(),
          SizedBox(height: 8),
          HelpMenuList(),
        ],
      ),
    );
  }
}
