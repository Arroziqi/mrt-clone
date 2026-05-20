import 'package:equatable/equatable.dart';

enum NotificationCategory { all, promo, info }

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final NotificationCategory category;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.category,
    this.isRead = false,
  });

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        title: title,
        body: body,
        createdAt: createdAt,
        category: category,
        isRead: isRead ?? this.isRead,
      );

  @override
  List<Object> get props => [id, title, body, createdAt, category, isRead];
}

/// Seed data for the notification list.
final List<NotificationModel> kSeedNotifications = [
  NotificationModel(
    id: '1',
    title: '🎉 Weekend Promo — 30% Off!',
    body: 'Enjoy 30% discount on all MRT Jakarta trips this weekend. Use code WEEKEND30 at checkout.',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    category: NotificationCategory.promo,
    isRead: false,
  ),
  NotificationModel(
    id: '2',
    title: 'Service Update – Bundaran HI Station',
    body: 'Temporary platform adjustment at Bundaran HI. Please allow extra travel time on Saturday, 24 May.',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    category: NotificationCategory.info,
    isRead: false,
  ),
  NotificationModel(
    id: '3',
    title: 'New Route Available',
    body: 'The new Lebak Bulus ↔ Fatmawati extension is now open. Check the schedule for details.',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    category: NotificationCategory.info,
    isRead: true,
  ),
  NotificationModel(
    id: '4',
    title: '🎁 Referral Bonus Credited',
    body: 'Your referral bonus of Rp 10,000 has been credited to your MRT wallet. Thank you for sharing!',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    category: NotificationCategory.promo,
    isRead: true,
  ),
  NotificationModel(
    id: '5',
    title: 'Scheduled Maintenance Notice',
    body: 'MRT Jakarta will undergo routine maintenance from 00:00–04:00 on Sunday, 25 May. Plan accordingly.',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    category: NotificationCategory.info,
    isRead: true,
  ),
  NotificationModel(
    id: '6',
    title: '🌟 Flash Sale – Today Only',
    body: 'Get unlimited rides for just Rp 25,000 today only. Offer valid until midnight.',
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    category: NotificationCategory.promo,
    isRead: true,
  ),
];
