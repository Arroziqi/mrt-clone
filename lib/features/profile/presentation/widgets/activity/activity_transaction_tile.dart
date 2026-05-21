import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../features/ticket/data/models/transaction_model.dart';

/// List tile for a transaction in the Activity History page.
class ActivityTransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const ActivityTransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(transaction.status);
    final statusIcon = _statusIcon(transaction.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, color: statusColor, size: 20),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        transaction.ticket != null
                            ? '${transaction.ticket!.departureName} → ${transaction.ticket!.destinationName}'
                            : 'MRT Ticket',
                        style: AppTextStyle.body.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatRp(transaction.finalAmount),
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      _formatDate(transaction.createdAt),
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        transaction.status,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (transaction.ticket != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${transaction.ticket!.passengers} pax'
                    '${transaction.ticket!.isRoundTrip ? ' · Round Trip' : ''}'
                    '${transaction.voucherCode != null ? ' · Voucher: ${transaction.voucherCode}' : ''}',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'PAID':
        return AppColors.primaryGreen;
      case 'PENDING':
        return const Color(0xFFE65100);
      case 'FAILED':
        return const Color(0xFFD32F2F);
      case 'EXPIRED':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'PAID':
        return Icons.check_circle_rounded;
      case 'PENDING':
        return Icons.access_time_rounded;
      case 'FAILED':
        return Icons.cancel_rounded;
      case 'EXPIRED':
        return Icons.timer_off_rounded;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
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
