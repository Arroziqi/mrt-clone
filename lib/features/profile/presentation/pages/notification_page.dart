import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/empty_state_view.dart';
import '../../data/notification_model.dart';
import '../widgets/notification/notification_illustration.dart';
import '../widgets/notification/notification_item.dart';

/// Notification page with category tabs (All / Promo / Info),
/// mark-all-read action, swipe-to-dismiss, and an empty state fallback.
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<NotificationModel> _notifications = List.from(kSeedNotifications);

  static const _tabs = [
    NotificationCategory.all,
    NotificationCategory.promo,
    NotificationCategory.info,
  ];

  static const _tabLabels = ['All', 'Promo', 'Info'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationModel> get _filtered {
    final cat = _tabs[_tabController.index];
    if (cat == NotificationCategory.all) return _notifications;
    return _notifications.where((n) => n.category == cat).toList();
  }

  int get _unreadCount =>
      _notifications.where((n) => !n.isRead).length;

  void _markAllRead() {
    setState(() {
      _notifications = _notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
    });
  }

  void _markRead(String id) {
    setState(() {
      _notifications = _notifications
          .map((n) => n.id == id ? n.copyWith(isRead: true) : n)
          .toList();
    });
  }

  void _remove(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }

  void _showDetail(NotificationModel notification) {
    _markRead(notification.id);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NotificationDetailSheet(notification: notification),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Notification'),
            if (_unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$_unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
        centerTitle: false,
        leading: const BackButton(),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(
                'Mark all read',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabLabels.asMap().entries.map((e) {
            final cat = _tabs[e.key];
            final count = cat == NotificationCategory.all
                ? _notifications.where((n) => !n.isRead).length
                : _notifications
                    .where((n) => n.category == cat && !n.isRead)
                    .length;
            return Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(e.value),
                  if (count > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
          indicatorColor: AppColors.primaryBlue,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: filtered.isEmpty
          ? Center(
              child: EmptyStateView(
                illustration: const NotificationIllustration(),
                heading: 'No notifications',
                subtitle:
                    'There are no notifications here yet. Please wait for the latest news from us, MRT friends.',
              ),
            )
          : ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final item = filtered[index];
                return NotificationItem(
                  notification: item,
                  onTap: () => _showDetail(item),
                  onDismiss: () => _remove(item.id),
                );
              },
            ),
    );
  }
}

/// Detail bottom sheet for a single notification.
class _NotificationDetailSheet extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationDetailSheet({required this.notification});

  Color get _bgColor {
    switch (notification.category) {
      case NotificationCategory.promo:
        return const Color(0xFFFFF3E0);
      case NotificationCategory.info:
        return const Color(0xFFE3F2FD);
      case NotificationCategory.all:
        return AppColors.background;
    }
  }

  Color get _iconColor {
    switch (notification.category) {
      case NotificationCategory.promo:
        return const Color(0xFFF57C00);
      case NotificationCategory.info:
        return AppColors.primaryBlue;
      case NotificationCategory.all:
        return AppColors.textSecondary;
    }
  }

  IconData get _icon {
    switch (notification.category) {
      case NotificationCategory.promo:
        return Icons.local_offer_outlined;
      case NotificationCategory.info:
        return Icons.info_outline;
      case NotificationCategory.all:
        return Icons.notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(_icon, color: _iconColor, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            notification.title,
            style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            notification.body,
            style: AppTextStyle.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _formatDate(notification.createdAt),
            style: AppTextStyle.bodySmall,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${dt.day} ${months[dt.month]} ${dt.year} · ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
