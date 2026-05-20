import 'ticket_model.dart';

/// Model representing a transaction from the backend API.
class TransactionModel {
  final String orderId;
  final String status; // PENDING, PAID, FAILED, EXPIRED
  final double grossAmount;
  final double discountAmount;
  final double finalAmount;
  final String? voucherCode;
  final String? paymentType;
  final TicketModel? ticket;
  final DateTime? paidAt;
  final DateTime? expiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionModel({
    required this.orderId,
    required this.status,
    required this.grossAmount,
    required this.discountAmount,
    required this.finalAmount,
    this.voucherCode,
    this.paymentType,
    this.ticket,
    this.paidAt,
    this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      orderId: json['orderId'] ?? '',
      status: json['status'] ?? 'PENDING',
      grossAmount: (json['grossAmount'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json['finalAmount'] as num?)?.toDouble() ?? 0.0,
      voucherCode: json['voucherCode'],
      paymentType: json['paymentType'],
      ticket: json['ticket'] != null && json['ticket'] is Map<String, dynamic>
          ? TicketModel.fromJson(json['ticket'])
          : null,
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
      expiredAt: json['expiredAt'] != null ? DateTime.parse(json['expiredAt']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }

  /// Whether this transaction is awaiting payment.
  bool get isPending => status == 'PENDING';

  /// Whether this transaction was successfully paid.
  bool get isPaid => status == 'PAID';
}
