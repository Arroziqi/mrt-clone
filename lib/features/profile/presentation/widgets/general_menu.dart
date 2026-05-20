import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/routes/app_router.dart';
import '../../../../shared/widget/list_tile_item.dart';
import '../../bloc/language_cubit.dart';
import '../../bloc/language_state.dart';
import 'language_bottom_sheet.dart';

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
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, langState) {
            return ListTileItem(
              leading: const Icon(Icons.language, color: AppColors.primaryBlue, size: 28),
              title: 'Language',
              subtitle: '${langState.flagEmoji}  ${langState.displayName}',
              onTap: () => LanguageBottomSheet.show(context),
            );
          },
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.help_outline, color: AppColors.primaryBlue, size: 28),
          title: 'Help',
          onTap: () => context.push('/help'),
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.article_outlined, color: AppColors.primaryBlue, size: 28),
          title: 'Terms and Conditions',
          onTap: () => AppRouter.showTerms(context),
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primaryBlue, size: 28),
          title: 'Privacy Policy',
          onTap: () => AppRouter.showPrivacyPolicy(context),
        ),
        const Divider(indent: 24, endIndent: 24, height: 1),
        ListTileItem(
          leading: const Icon(Icons.system_update_outlined, color: AppColors.primaryBlue, size: 28),
          title: 'Application Version',
          subtitle: '4.16.0',
          trailing: const SizedBox.shrink(),
        ),
      ],
    );
  }
}
