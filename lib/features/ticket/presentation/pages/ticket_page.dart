import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../shared/widget/illustrations/ticket_illustration.dart';
import '../../../../shared/widget/illustrations/city_train_illustration.dart';
import '../bloc/ticket/ticket_cubit.dart';
import '../bloc/ticket/ticket_state.dart';
import '../widgets/active_ticket_card.dart';
import '../widgets/pending_transaction_card.dart';

/// Ticket page — shows active tickets + pending transactions.
/// Falls back to the animated empty state when both lists are empty.
class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  void initState() {
    super.initState();
    context.read<TicketCubit>().loadTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Ticket'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: () => context.push('/activity'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.history, size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        'History',
                        style: AppTextStyle.bodySmall.copyWith(color: AppColors.surface),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TicketCubit, TicketState>(
        builder: (context, state) {
          if (state is TicketLoading || state is TicketInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TicketError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<TicketCubit>().loadTickets(),
            );
          }

          if (state is TicketLoaded) {
            if (state.isEmpty) {
              return _EmptyState();
            }
            return RefreshIndicator(
              onRefresh: () => context.read<TicketCubit>().refresh(),
              child: ListView(
                children: [
                  if (state.pendingTransactions.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'Pending Payment',
                        style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    ...state.pendingTransactions.map(
                      (tx) => PendingTransactionCard(
                        transaction: tx,
                        onPayNow: () {
                          // Navigate to checkout / payment
                          if (tx.ticket != null) {
                            context.push('/checkout', extra: tx.orderId);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (state.activeTickets.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        'Active Tickets',
                        style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    ...state.activeTickets.map(
                      (ticket) => ActiveTicketCard(ticket: ticket),
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Buy more ticket button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppButton(
                      text: 'Buy Another Ticket',
                      onPressed: () => context.push('/buy-ticket'),
                      variant: AppButtonVariant.lightBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TicketIllustration(),
                    const SizedBox(height: 32),
                    Text(
                      'To use tickets, you need to purchase them first.',
                      style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'To be able to use tickets you need to buy it first.',
                      style: AppTextStyle.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Buy Ticket',
                      onPressed: () => context.push('/buy-ticket'),
                      variant: AppButtonVariant.primaryGreen,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const CityTrainIllustration(height: 100),
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
            Text(
              message,
              style: AppTextStyle.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Try Again',
              onPressed: onRetry,
              variant: AppButtonVariant.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
