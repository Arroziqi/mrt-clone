import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../shared/widget/app_textfield.dart';
import 'package:go_router/go_router.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppTextField(
          label: 'Phone Number',
          hint: '812 3456 7890',
          prefixText: '+62',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        const AppTextField(
          label: 'Full Name',
          hint: 'Input Full Name',
        ),
        const SizedBox(height: 16),
        const AppTextField(
          label: 'Email',
          hint: 'Input Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Checkbox(
              value: _agreedToTerms,
              onChanged: (value) {
                setState(() => _agreedToTerms = value ?? false);
              },
              activeColor: AppColors.primaryBlue,
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'I agree ',
                  style: AppTextStyle.bodySmall,
                  children: [
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryBlue),
                    ),
                    const TextSpan(text: ' of MyMRTJ'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        AppButton(
          text: 'Next',
          onPressed: _agreedToTerms ? () => context.push('/pin?isCreate=true') : null, // Disabled if not agreed
        ),
      ],
    );
  }
}
