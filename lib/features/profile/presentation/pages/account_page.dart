import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widget/app_button.dart';
import '../widgets/account/account_avatar_section.dart';
import '../widgets/account/account_info_banner.dart';
import '../widgets/account/account_form_section.dart';
import '../widgets/account/account_delete_button.dart';

/// Account / Change Profile page.
/// Thin assembler: all sections are their own widgets.
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Change profile'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const AccountAvatarSection(),
            const SizedBox(height: 24),
            const AccountInfoBanner(),
            const SizedBox(height: 28),
            const AccountFormSection(),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AppButton(
                text: 'Save',
                onPressed: () {},
                variant: AppButtonVariant.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            const AccountDeleteButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
