import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/ticket_search_card.dart';
import '../widgets/main_menu_grid.dart';
import '../widgets/lifestyle_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(
              child: TicketSearchCard(),
            ),
            const SizedBox(height: 240), // Space for the overlapping TicketSearchCard
            
            // Top Promo Banner Placeholder
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.card_giftcard, color: Colors.white, size: 40),
            ),
            
            const SizedBox(height: 32),
            const MainMenuGrid(),
            
            const SizedBox(height: 32),
            const LifestyleSection(),
            
            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }
}
