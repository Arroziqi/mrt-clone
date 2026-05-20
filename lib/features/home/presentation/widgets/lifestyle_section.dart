import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import 'home_section_header.dart';
import 'promo_card.dart';
import 'event_card.dart';
import 'residential_card.dart';
import 'lifestyle_banner.dart';

/// Composites all the lifestyle/promo/event sections below the menu grid
/// on the Home page. Each sub-section is kept at <80 LOC responsibility.
class LifestyleSection extends StatelessWidget {
  const LifestyleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Lifestyle (tabbed banner) ─────────────────────────────────
        HomeSectionHeader(
          title: 'Lifestyle',
          subtitle: 'Fulfill your lifestyle with MyMRTJ partners!',
          onViewAll: () {},
        ),
        const SizedBox(height: 12),
        const LifestyleBanner(),

        const SizedBox(height: 28),
        // ── Ticket Promo & Feeder ─────────────────────────────────────
        HomeSectionHeader(
          title: 'Ticket Promo & Feeder',
          subtitle: 'For a more efficient and easier trip.',
          onViewAll: () {},
        ),
        const SizedBox(height: 12),
        _TicketPromoList(),

        const SizedBox(height: 28),
        // ── Lifestyle Promo ───────────────────────────────────────────
        HomeSectionHeader(
          title: 'Lifestyle Promo',
          subtitle: 'Enhance your lifestyle for the better.',
          onViewAll: () {},
        ),
        const SizedBox(height: 12),
        _LifestylePromoList(),

        const SizedBox(height: 28),
        // ── Tourist Attraction & Events ───────────────────────────────
        HomeSectionHeader(
          title: 'Tourist attraction and Events',
          subtitle: 'View events and tourist attractions that you can visit using the MRT!',
          onViewAll: () {},
        ),
        const SizedBox(height: 12),
        _TouristEventList(),

        const SizedBox(height: 28),
        // ── Residential ───────────────────────────────────────────────
        HomeSectionHeader(
          title: 'Residential',
          subtitle: 'Residential and co-living info near MRT stations.',
          onViewAll: () {},
        ),
        const SizedBox(height: 12),
        _ResidentialList(),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-list widgets (each <60 LOC)
// ─────────────────────────────────────────────────────────────────────────────

class _TicketPromoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final promos = [
      _PromoData('Cashback Points 50%', '50%', AppColors.accentYellow, const Color(0xFF1565C0), const Color(0xFF0D47A1)),
      _PromoData('Cashback 100% blu', '100%', Colors.white, const Color(0xFF00838F), const Color(0xFF006064)),
      _PromoData('Cashback 100% GoPay', '100%', Colors.white, const Color(0xFF1B5E20), const Color(0xFF2E7D32)),
    ];
    return SizedBox(
      height: 160,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: promos.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => PromoCard(
          title: promos[i].title,
          badge: promos[i].badge,
          badgeColor: promos[i].badgeColor,
          bgColor: promos[i].bgColor,
          bgColorEnd: promos[i].bgColorEnd,
        ),
      ),
    );
  }
}

class _LifestylePromoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final promos = [
      _PromoData('Diskon 45% Single Class Pilates', '45%', AppColors.accentYellow, const Color(0xFF4A3728), const Color(0xFF5D4037)),
      _PromoData('Diskon 15% UP at Thamrin Nine', '15%', Colors.white, const Color(0xFF0277BD), const Color(0xFF01579B)),
      _PromoData('Buy 1 Get 1 Nasi Goreng Semangat', 'B1G1', Colors.white, const Color(0xFFE65100), const Color(0xFFBF360C)),
    ];
    return SizedBox(
      height: 160,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: promos.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => PromoCard(
          title: promos[i].title,
          badge: promos[i].badge,
          badgeColor: promos[i].badgeColor,
          bgColor: promos[i].bgColor,
          bgColorEnd: promos[i].bgColorEnd,
        ),
      ),
    );
  }
}

class _TouristEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = [
      _EventData('ONE OK ROCK DETOX Asia Tour 2026', 'Concert', const Color(0xFF1A1A2E), Icons.music_note),
      _EventData('Rips & Run 2026', 'Sport', const Color(0xFF1B5E20), Icons.directions_run),
      _EventData('Symphony Worship Family', 'Concert', const Color(0xFF4A148C), Icons.queue_music),
      _EventData('Wisata Edukasi MRT Jakarta', 'Education', const Color(0xFF1565C0), Icons.school),
    ];
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => EventCard(
          title: events[i].title,
          category: events[i].category,
          placeholderColor: events[i].color,
          icon: events[i].icon,
        ),
      ),
    );
  }
}

class _ResidentialList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final residentials = [
      _ResidentialData('Cove Taman Haji Nawi', 'PT Cove Living Indon...', const Color(0xFF795548)),
      _ResidentialData('Cove Sixth8 Blok M', 'PT Cove Living Indon...', const Color(0xFF607D8B)),
      _ResidentialData('Cove District Station M', 'PT Cove Living Indon...', const Color(0xFF546E7A)),
      _ResidentialData('Rukita Wood Residence', 'Rukita', const Color(0xFF6D4C41)),
    ];
    return SizedBox(
      height: 195,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: residentials.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, i) => ResidentialCard(
          name: residentials[i].name,
          provider: residentials[i].provider,
          placeholderColor: residentials[i].color,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Simple data holders (no state, no logic)
// ─────────────────────────────────────────────────────────────────────────────

class _PromoData {
  final String title, badge;
  final Color badgeColor, bgColor, bgColorEnd;
  const _PromoData(this.title, this.badge, this.badgeColor, this.bgColor, this.bgColorEnd);
}

class _EventData {
  final String title, category;
  final Color color;
  final IconData icon;
  const _EventData(this.title, this.category, this.color, this.icon);
}

class _ResidentialData {
  final String name, provider;
  final Color color;
  const _ResidentialData(this.name, this.provider, this.color);
}
