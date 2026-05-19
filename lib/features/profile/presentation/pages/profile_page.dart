import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widget/list_tile_item.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_event.dart';
import '../widgets/profile_header.dart';
import '../widgets/general_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            const SizedBox(height: 24),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                'Profile Menu',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            ListTileItem(
              leading: const Icon(Icons.account_circle_outlined, color: AppColors.primaryBlue, size: 28),
              title: 'Account',
              subtitle: 'Change your account data',
              onTap: () {},
            ),
            const Divider(indent: 24, endIndent: 24, height: 1),
            ListTileItem(
              leading: const Icon(Icons.domain, color: AppColors.primaryBlue, size: 28),
              title: 'Business Account',
              subtitle: 'You are using personal mode',
              trailing: Switch(
                value: false,
                onChanged: (val) {},
                activeThumbColor: AppColors.primaryBlue,
              ),
            ),
            const Divider(indent: 24, endIndent: 24, height: 1),
            ListTileItem(
              leading: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.primaryBlue, size: 28),
              title: 'Payment',
              subtitle: 'Set up your connected payment',
              onTap: () {},
            ),
            const Divider(indent: 24, endIndent: 24, height: 1),
            ListTileItem(
              leading: const Icon(Icons.history, color: AppColors.primaryBlue, size: 28),
              title: 'Activity History',
              subtitle: 'Past ticket history',
              onTap: () {},
            ),
            
            const SizedBox(height: 24),
            const GeneralMenu(),
            
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AppButton(
                text: 'Log out',
                onPressed: () {
                  context.read<AuthBloc>().add(LoggedOut());
                },
                variant: AppButtonVariant.logout,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
