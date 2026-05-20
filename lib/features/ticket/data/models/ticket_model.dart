import '../../../../shared/models/mrt_station.dart';

/// Model representing a ticket from the backend API.
class TicketModel {
  final String id;
  final String? transactionId;
  final String departureStation;
  final String destinationStation;
  final int passengers;
  final bool isRoundTrip;
  final bool addOnProteksi;
  final double totalPrice;
  final String status; // PENDING, ACTIVE, USED, EXPIRED
  final String? qrCodeData;
  final DateTime? purchasedAt;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TicketModel({
    required this.id,
    this.transactionId,
    required this.departureStation,
    required this.destinationStation,
    required this.passengers,
    required this.isRoundTrip,
    required this.addOnProteksi,
    required this.totalPrice,
    required this.status,
    this.qrCodeData,
    this.purchasedAt,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? json['_id'] ?? '',
      transactionId: json['transaction'],
      departureStation: json['departureStation'] ?? '',
      destinationStation: json['destinationStation'] ?? '',
      passengers: json['passengers'] ?? 1,
      isRoundTrip: json['isRoundTrip'] ?? false,
      addOnProteksi: json['addOnProteksi'] ?? false,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'PENDING',
      qrCodeData: json['qrCodeData'],
      purchasedAt: json['purchasedAt'] != null ? DateTime.parse(json['purchasedAt']) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }

  /// Resolve departure station name from local station list.
  String get departureName {
    final station = kMrtStations.where((s) => s.id == departureStation).firstOrNull;
    return station?.name ?? departureStation;
  }

  /// Resolve destination station name from local station list.
  String get destinationName {
    final station = kMrtStations.where((s) => s.id == destinationStation).firstOrNull;
    return station?.name ?? destinationStation;
  }

  /// Check if the ticket is expired.
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
}
