import 'package:flutter/material.dart';
import '../../../../shared/widget/app_button.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SocialLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'Log In with Google',
      onPressed: onPressed,
      variant: AppButtonVariant.social,
      iconPath: 'google_icon_placeholder', // Added a placeholder for icon logic
    );
  }
}
