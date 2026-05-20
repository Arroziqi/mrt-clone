import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../shared/widget/app_textfield.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/domain/models/user_model.dart';
import '../widgets/account/account_avatar_section.dart';
import '../widgets/account/account_info_banner.dart';
import '../widgets/account/account_delete_button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedAge;

  static const _ages = ['< 17', '17–25', '26–35', '36–45', '> 45'];

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      final user = authState.user;
      _nameController.text = user.fullName;
      _phoneController.text = user.phoneNumber;
      _emailController.text = user.email;
      // Note: mapping age int to string could be done here if needed.
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onSave(UserModel currentUser) {
    final updatedUser = currentUser.copyWith(
      fullName: _nameController.text,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
      // age: map _selectedAge if necessary
    );
    context.read<AuthBloc>().add(ProfileUpdated(user: updatedUser));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final user = state.user;

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(label: 'Full Name', controller: _nameController),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Phone Number',
                        prefixText: '+62',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      _buildAgeDropdown(),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AppButton(
                    text: 'Save',
                    onPressed: () => _onSave(user),
                    variant: AppButtonVariant.primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),
                AccountDeleteButton(
                  onTap: () => _showDeleteDialog(context),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAgeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age',
          style: AppTextStyle.bodySmall.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedAge,
              hint: const Text(''),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
              onChanged: (val) => setState(() => _selectedAge = val),
              items: _ages.map((a) => DropdownMenuItem(value: a, child: Text(a))).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Close dialog
              context.read<AuthBloc>().add(AccountDeleted());
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.logoutText)),
          ),
        ],
      ),
    );
  }
}
