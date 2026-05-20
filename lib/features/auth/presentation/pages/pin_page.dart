import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class PinPage extends StatefulWidget {
  final bool isCreate;

  const PinPage({super.key, this.isCreate = false});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String _pin = '';
  final int _pinLength = 6;

  void _onKeypadPressed(String value) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += value;
      });
      if (_pin.length == _pinLength) {
        _submitPin();
      }
    }
  }

  void _onBackspacePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _submitPin() {
    // Dispatch LoggedIn event to mock the authentication success
    context.read<AuthBloc>().add(const LoggedIn(
      phoneNumber: 'mock_phone',
      password: 'mock_password',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                widget.isCreate ? 'Create PIN' : 'Enter PIN',
                style: AppTextStyle.title.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pinLength, (index) {
                  final isFilled = index < _pin.length;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? AppColors.primaryBlue : const Color(0xFFE5E9F2),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  widget.isCreate
                      ? 'Please create a 6-digit PIN to be remembered as authentication for signing in'
                      : 'Please enter your 6-digit PIN to sign in securely',
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              _buildKeypad(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKeypadButton('1'),
              _buildKeypadButton('2'),
              _buildKeypadButton('3'),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKeypadButton('4'),
              _buildKeypadButton('5'),
              _buildKeypadButton('6'),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKeypadButton('7'),
              _buildKeypadButton('8'),
              _buildKeypadButton('9'),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 64, height: 64), // Empty space
              _buildKeypadButton('0'),
              SizedBox(
                width: 64,
                height: 64,
                child: IconButton(
                  onPressed: _onBackspacePressed,
                  icon: const Icon(Icons.backspace_outlined, size: 28),
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadButton(String number) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextButton(
        onPressed: () => _onKeypadPressed(number),
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          foregroundColor: AppColors.textPrimary,
        ),
        child: Text(
          number,
          style: AppTextStyle.headline.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
