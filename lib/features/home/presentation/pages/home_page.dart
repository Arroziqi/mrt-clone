import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../widgets/home_header.dart';
import '../widgets/ticket_search_card.dart';
import '../widgets/main_menu_grid.dart';
import '../widgets/lifestyle_section.dart';
import '../widgets/home_top_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Sticky-ish blue header with the ticket search card
          SliverToBoxAdapter(
            child: HomeHeader(child: const TicketSearchCard()),
          ),

          // Space reserved for the overlapping TicketSearchCard
          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Top promo banner (auto-scrolling)
          const SliverToBoxAdapter(child: HomeTopBanner()),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // MyMRTJ Menu grid
          SliverToBoxAdapter(child: MainMenuGrid()),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // All lifestyle / promo / event / residential sections
          const SliverToBoxAdapter(child: LifestyleSection()),

          const SliverToBoxAdapter(child: SizedBox(height: 56)),
        ],
      ),
    );
  }
}
