import 'package:flutter/material.dart';
import 'app_bottom_nav.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/ticket/presentation/pages/ticket_empty_page.dart';
import '../../features/subscription/presentation/pages/subscription_empty_page.dart';
import '../../features/profile/presentation/pages/profile_wrapper.dart'; // We'll create this to handle auth/unauth profile
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TicketEmptyPage(),
    const SubscriptionEmptyPage(),
    const ProfileWrapper(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isAuthenticated = state is Authenticated;
          return FloatingActionButton.extended(
            onPressed: () {
              if (isAuthenticated) {
                context.read<AuthBloc>().add(LoggedOut());
              } else {
                context.read<AuthBloc>().add(const LoggedIn(phoneNumber: 'debug', password: 'debug'));
              }
            },
            icon: Icon(isAuthenticated ? Icons.logout : Icons.login),
            label: Text(isAuthenticated ? 'Test Unauth' : 'Test Auth'),
            backgroundColor: isAuthenticated ? Colors.redAccent : Colors.green,
          );
        },
      ),
    );
  }
}
