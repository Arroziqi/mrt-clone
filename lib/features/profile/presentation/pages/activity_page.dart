import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/segment_tab_bar.dart';
import '../../../../shared/widget/empty_state_view.dart';
import '../../bloc/activity_cubit.dart';
import '../../bloc/activity_state.dart';
import '../widgets/activity/activity_illustration.dart';
import '../widgets/activity/activity_transaction_tile.dart';

/// Activity History page with API integration.
/// Shows paginated transaction history with tab filtering.
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int _tabIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final _statusFilters = [null, 'PAID', 'PENDING', 'FAILED'];
  final _tabLabels = ['All', 'Paid', 'Pending', 'Failed'];

  @override
  void initState() {
    super.initState();
    context.read<ActivityCubit>().loadActivity();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ActivityCubit>().loadMore();
    }
  }

  void _onTabChanged(int index) {
    setState(() => _tabIndex = index);
    context.read<ActivityCubit>().loadActivity(status: _statusFilters[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Activity History'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          // Tab bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SegmentTabBar(
              labels: _tabLabels,
              selectedIndex: _tabIndex,
              onTabChanged: _onTabChanged,
            ),
          ),
          const SizedBox(height: 12),
          // Content
          Expanded(
            child: BlocBuilder<ActivityCubit, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ActivityError) {
                  return _ErrorView(
                    message: state.message,
                    onRetry: () => context
                        .read<ActivityCubit>()
                        .loadActivity(status: _statusFilters[_tabIndex]),
                  );
                }

                if (state is ActivityLoaded) {
                  if (state.isEmpty) {
                    return Center(
                      child: EmptyStateView(
                        illustration: const ActivityIllustration(),
                        heading: 'No transactions found',
                        subtitle: 'No activity was found. Try a different filter.',
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => context.read<ActivityCubit>().refresh(),
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 24),
                      itemCount: state.transactions.length +
                          (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.transactions.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return ActivityTransactionTile(
                          transaction: state.transactions[index],
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 56, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(message, style: AppTextStyle.body, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
