import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/segment_tab_bar.dart';
import '../../../../shared/widget/empty_state_view.dart';
import '../widgets/activity/activity_date_row.dart';
import '../widgets/activity/activity_illustration.dart';

/// Activity History page.
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Activity History'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ActivityDateRow(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SegmentTabBar(
                labels: const ['Ticket Issuance', 'Subscription Package'],
                selectedIndex: _tabIndex,
                onTabChanged: (i) => setState(() => _tabIndex = i),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'List Transaction',
                style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: EmptyStateView(
                illustration: const ActivityIllustration(),
                heading: 'No data found',
                subtitle: 'No activity was found on that date. Please try another date.',
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
