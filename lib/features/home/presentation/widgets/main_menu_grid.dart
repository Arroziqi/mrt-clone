import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_text_style.dart';
import 'menu_grid_item.dart';

class _MenuEntry {
  final IconData icon;
  final String label;
  final bool isNew;
  final Color bgColor;
  const _MenuEntry(this.icon, this.label, {this.isNew = false, this.bgColor = const Color(0xFFE8F0FB)});
}

const List<_MenuEntry> _kMenuItems = [
  _MenuEntry(Icons.directions_bike, 'allride\nCharm', isNew: true, bgColor: Color(0xFFFFECE0)),
  _MenuEntry(Icons.motorcycle, 'Maxride', isNew: true, bgColor: Color(0xFFE8F0FB)),
  _MenuEntry(Icons.confirmation_number_outlined, 'Ticket', bgColor: Color(0xFFE8F0FB)),
  _MenuEntry(Icons.schedule, 'Schedule', bgColor: Color(0xFFE8F0FB)),
  _MenuEntry(Icons.train, 'Station', bgColor: Color(0xFFE8F0FB)),
  _MenuEntry(Icons.store, 'Tenant', bgColor: Color(0xFFE8F0FB)),
  _MenuEntry(Icons.stars, 'Points', bgColor: Color(0xFFFFF9C4)),
  _MenuEntry(Icons.more_horiz, 'Other', bgColor: Color(0xFFF5F5F5)),
];

const Map<int, String> _kRoutes = {
  2: '/buy-ticket',  // Ticket
  3: '/schedule',   // Schedule
};

/// The MyMRTJ Menu grid showing 8 icons in two rows.
class MainMenuGrid extends StatelessWidget {
  const MainMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MyMRTJ Menu',
            style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            'Enjoy our various features for your mobility & your lifestyle!',
            style: AppTextStyle.bodySmall,
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
              childAspectRatio: 0.72,
            ),
            itemCount: _kMenuItems.length,
            itemBuilder: (_, i) {
              final e = _kMenuItems[i];
              return GestureDetector(
                onTap: () {
                  final route = _kRoutes[i];
                  if (route != null) context.push(route);
                },
                child: MenuGridItem(
                  icon: e.icon,
                  label: e.label,
                  iconBgColor: e.bgColor,
                  isNew: e.isNew,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
