class PaymentRequest {
  final String departureId;
  final String destinationId;
  final int passengers;
  final bool isRoundTrip;
  final bool addOnProteksi;
  final String? voucherCode;

  PaymentRequest({
    required this.departureId,
    required this.destinationId,
    required this.passengers,
    required this.isRoundTrip,
    required this.addOnProteksi,
    this.voucherCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'departureId': departureId,
      'destinationId': destinationId,
      'passengers': passengers,
      'isRoundTrip': isRoundTrip,
      'addOnProteksi': addOnProteksi,
      if (voucherCode != null && voucherCode!.isNotEmpty) 'voucherCode': voucherCode,
    };
  }
}

class PaymentResponse {
  final String orderId;
  final double grossAmount;
  final double discountAmount;
  final double finalAmount;
  final String? voucherCode;
  final String invoiceUrl;

  PaymentResponse({
    required this.orderId,
    required this.grossAmount,
    required this.discountAmount,
    required this.finalAmount,
    this.voucherCode,
    required this.invoiceUrl,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      orderId: json['orderId'] ?? '',
      grossAmount: (json['grossAmount'] as num?)?.toDouble() ?? 0.0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0.0,
      finalAmount: (json['finalAmount'] as num?)?.toDouble() ?? 0.0,
      voucherCode: json['voucherCode'],
      invoiceUrl: json['invoiceUrl'] ?? '',
    );
  }
}

class TransactionStatusResponse {
  final String orderId;
  final String status; // PENDING, PAID, FAILED, EXPIRED
  final double finalAmount;

  TransactionStatusResponse({
    required this.orderId,
    required this.status,
    required this.finalAmount,
  });

  factory TransactionStatusResponse.fromJson(Map<String, dynamic> json) {
    return TransactionStatusResponse(
      orderId: json['orderId'] ?? '',
      status: json['status'] ?? 'PENDING',
      finalAmount: (json['finalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
