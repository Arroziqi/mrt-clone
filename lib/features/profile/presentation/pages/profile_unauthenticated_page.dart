import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';
import '../widgets/general_menu.dart';

class ProfileUnauthenticatedPage extends StatelessWidget {
  const ProfileUnauthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You\'re Not Logged In',
                    style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To enjoy the full features of the MyMRTJ app, you need to log in first.',
                    style: AppTextStyle.body,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Register',
                          onPressed: () => context.push('/register'),
                          variant: AppButtonVariant.lightBlue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppButton(
                          text: 'Log In',
                          onPressed: () => context.push('/login'),
                          variant: AppButtonVariant.lightGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(height: 8, color: AppColors.background),
            const SizedBox(height: 16),
            const GeneralMenu(),
          ],
        ),
      ),
    );
  }
}
