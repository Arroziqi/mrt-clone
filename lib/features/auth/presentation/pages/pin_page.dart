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
  final String phoneNumber;
  final String? fullName;
  final String? email;

  const PinPage({
    super.key,
    this.isCreate = false,
    required this.phoneNumber,
    this.fullName,
    this.email,
  });

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String _pin = '';
  final int _pinLength = 6;
  bool _isSubmitting = false;

  void _onKeypadPressed(String value) {
    if (_isSubmitting) return;
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
    if (_isSubmitting) return;
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _submitPin() {
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    if (widget.isCreate) {
      context.read<AuthBloc>().add(Registered(
        fullName: widget.fullName ?? '',
        email: widget.email ?? '',
        phoneNumber: widget.phoneNumber,
        pin: _pin,
      ));
    } else {
      context.read<AuthBloc>().add(LoggedIn(
        phoneNumber: widget.phoneNumber,
        password: _pin,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/');
        } else if (state is AuthError) {
          setState(() {
            _isSubmitting = false;
            _pin = '';
          });
          // Strip "Exception: " prefix from error messages for cleaner display
          final message = state.message.replaceFirst(RegExp(r'^Exception:\s*'), '');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
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
            onPressed: _isSubmitting ? null : () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
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
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFilled
                              ? AppColors.primaryBlue
                              : const Color(0xFFE5E9F2),
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
              // Loading overlay
              if (_isSubmitting)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.15),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: Opacity(
        opacity: _isSubmitting ? 0.4 : 1.0,
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
                    onPressed: _isSubmitting ? null : _onBackspacePressed,
                    icon: const Icon(Icons.backspace_outlined, size: 28),
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadButton(String number) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextButton(
        onPressed: _isSubmitting ? null : () => _onKeypadPressed(number),
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
