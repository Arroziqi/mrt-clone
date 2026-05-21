import 'package:flutter/material.dart';
import 'app_bottom_nav.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/ticket/presentation/pages/ticket_page.dart';
import '../../features/subscription/presentation/pages/subscription_empty_page.dart';
import '../../features/profile/presentation/pages/profile_wrapper.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TicketPage(),
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
    );
  }
}

