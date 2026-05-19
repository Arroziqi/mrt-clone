import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void _onNavSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _buildStationInput(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Select $label Station',
            style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyle.bodySmall.copyWith(color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPromoCard(String title, String subtitle, Color color) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.title.copyWith(
              color: AppColors.surface,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: AppTextStyle.body.copyWith(color: AppColors.surface),
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(
                Icons.arrow_forward,
                color: AppColors.surface,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'View Offer',
                style: AppTextStyle.body.copyWith(
                  color: AppColors.surface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToTicket() {
    setState(() {
      selectedIndex = 1;
    });
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryContainer],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome MRT Friends',
                      style: AppTextStyle.title.copyWith(
                        color: AppColors.surface,
                      ),
                    ),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0x2EFFFFFF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: AppColors.surface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    const Icon(Icons.train, color: AppColors.surface, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Where do you go today?',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.surface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildStationInput('Departure'),
                const SizedBox(height: 12),
                _buildStationInput('Destination'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _navigateToTicket,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Buy Ticket'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'MyMRTJ Menu',
            style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildFeatureItem(Icons.qr_code, 'Scan'),
                _buildFeatureItem(Icons.schedule, 'Schedule'),
                _buildFeatureItem(Icons.location_on, 'Station'),
                _buildFeatureItem(Icons.confirmation_number, 'Ticket'),
                _buildFeatureItem(Icons.local_activity, 'Event'),
                _buildFeatureItem(Icons.more_horiz, 'More'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ticket Promo & Feature',
                style: AppTextStyle.title.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'View All',
                style: AppTextStyle.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPromoCard(
                  'Festival Offer',
                  'Enjoy priority booking for special events.',
                  AppColors.primary,
                ),
                _buildPromoCard(
                  'Lifestyle Promo',
                  'Discover exclusive discounts for MRT users.',
                  AppColors.secondary,
                ),
                _buildPromoCard(
                  'Travel Pass',
                  'Save more on your daily commute.',
                  AppColors.primaryVariant,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Lifestyle',
            style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live your lifestyle with MyMRTJ partners',
                  style: AppTextStyle.body.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPromoChip(Icons.local_offer, 'Events'),
                    _buildPromoChip(Icons.account_balance, 'Banking'),
                    _buildPromoChip(Icons.movie, 'Entertainment'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }

  Widget _buildScreenPlaceholder(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 96, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyle.title.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            'This section is under construction.',
            style: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageBody() {
    switch (selectedIndex) {
      case 1:
        return _buildScreenPlaceholder(
          'Ticket',
          Icons.confirmation_number_outlined,
        );
      case 2:
        return _buildScreenPlaceholder(
          'Subscription',
          Icons.card_membership_outlined,
        );
      case 3:
        return _buildScreenPlaceholder('Profile', Icons.person_outline);
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _buildPageBody()),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onNavSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'Ticket',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_membership_outlined),
            selectedIcon: Icon(Icons.card_membership),
            label: 'Subscription',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildPromoChip(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                style: AppTextStyle.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
