import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../widgets/login_form.dart';
import '../widgets/social_login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                // Logo Placeholder
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('M', style: AppTextStyle.headline.copyWith(color: AppColors.primaryBlue, fontSize: 40)),
                          Text('R', style: AppTextStyle.headline.copyWith(color: AppColors.primaryBlue, fontSize: 40)),
                          Text('T', style: AppTextStyle.headline.copyWith(color: AppColors.primaryGreen, fontSize: 40)),
                          const SizedBox(width: 8),
                          Text('jakarta', style: AppTextStyle.title.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'increasing mobility, improving life quality',
                        style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryBlue, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  'Login to MyMRTJ Account',
                  style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                const LoginForm(),
                const SizedBox(height: 32),
                SocialLoginButton(onPressed: () {}),
                const SizedBox(height: 48),
                // Cityscape Background Placeholder (using an image or container)
                SizedBox(
                  height: 100,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 80,
                        color: Colors.blue.withOpacity(0.05), // Placeholder for cityscape
                      ),
                      Container(
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        ), // Placeholder for train
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
