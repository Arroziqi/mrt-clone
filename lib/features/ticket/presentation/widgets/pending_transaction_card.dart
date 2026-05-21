import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../data/models/transaction_model.dart';

/// Card displaying a pending transaction awaiting payment.
class PendingTransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onPayNow;

  const PendingTransactionCard({
    super.key,
    required this.transaction,
    this.onPayNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFCC02).withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFCC02).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Warning header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFFFCC02).withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: Color(0xFFE65100),
                ),
                const SizedBox(width: 6),
                Text(
                  'Pending Payment',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: const Color(0xFFE65100),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                if (transaction.expiredAt != null)
                  Text(
                    'Expires ${_timeRemaining(transaction.expiredAt!)}',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: const Color(0xFFE65100),
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${transaction.orderId.length > 10 ? transaction.orderId.substring(transaction.orderId.length - 10) : transaction.orderId}',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (transaction.ticket != null) ...[
                            Text(
                              '${transaction.ticket!.departureName} → ${transaction.ticket!.destinationName}',
                              style: AppTextStyle.body.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${transaction.ticket!.passengers} passenger${transaction.ticket!.passengers > 1 ? 's' : ''}${transaction.ticket!.isRoundTrip ? ' · Round Trip' : ''}',
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ] else ...[
                            Text(
                              'MRT Ticket',
                              style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatRp(transaction.finalAmount),
                          style: AppTextStyle.body.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryBlue,
                            fontSize: 15,
                          ),
                        ),
                        if (transaction.discountAmount > 0) ...[
                          const SizedBox(height: 2),
                          Text(
                            'Save ${_formatRp(transaction.discountAmount)}',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.primaryGreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Pay Now button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onPayNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.payment_rounded, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Pay Now',
                          style: AppTextStyle.button.copyWith(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeRemaining(DateTime expiry) {
    final diff = expiry.difference(DateTime.now());
    if (diff.isNegative) return 'expired';
    if (diff.inHours > 0) return 'in ${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
    return 'in ${diff.inMinutes}m';
  }

  String _formatRp(double amount) {
    final s = amount.toInt().toString();
    final buf = StringBuffer('Rp ');
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}
