import 'package:flutter/material.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../shared/widget/app_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onLogin() {
    // In a real app, validate input first
    context.read<AuthBloc>().add(LoggedIn(
      phoneNumber: _phoneController.text,
      password: 'mock_password',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Phone Number',
          hint: '812 3456 7890',
          prefixText: '+62',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 24),
        AppButton(
          text: 'Log In',
          onPressed: _onLogin,
          variant: AppButtonVariant.primaryBlue,
        ),
        const SizedBox(height: 16),
        Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('Don\'t have an account? '),
              InkWell(
                onTap: () => context.push('/register'),
                child: Text(
                  'Register Here!',
                  style: AppTextStyle.body.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
