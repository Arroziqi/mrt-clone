import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/pin_page.dart';
import '../../features/ticket/presentation/pages/buy_ticket_page.dart';
import '../../features/ticket/presentation/pages/schedule_page.dart';
import '../../features/ticket/presentation/pages/payment_page.dart';
import '../../features/profile/presentation/pages/notification_page.dart';
import '../../features/profile/presentation/pages/account_page.dart';
import '../../features/profile/presentation/pages/activity_page.dart';
import '../../features/profile/presentation/pages/payment_settings_page.dart';
import '../../features/profile/presentation/pages/help_page.dart';
import '../../features/profile/presentation/pages/faq_page.dart';
import '../../features/profile/presentation/pages/privacy_policy_page.dart';
import '../../features/profile/presentation/pages/terms_page.dart';
import '../../shared/models/mrt_station.dart';
import '../../shared/widget/main_scaffold.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScaffold(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/pin',
        builder: (context, state) {
          final isCreate = state.uri.queryParameters['isCreate'] == 'true';
          final extra = state.extra as Map<String, dynamic>?;
          return PinPage(
            isCreate: isCreate,
            phoneNumber: extra?['phoneNumber'] as String? ?? '',
            fullName: extra?['fullName'] as String?,
            email: extra?['email'] as String?,
          );
        },
      ),
      GoRoute(
        path: '/buy-ticket',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final departure = extra?['departure'] as MrtStation?;
          final destination = extra?['destination'] as MrtStation?;
          return BuyTicketPage(
            initialDeparture: departure,
            initialDestination: destination,
          );
        },
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const SchedulePage(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentPage(),
      ),
      // Profile sub-pages
      GoRoute(
        path: '/notification',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/account',
        builder: (context, state) => const AccountPage(),
      ),
      GoRoute(
        path: '/activity',
        builder: (context, state) => const ActivityPage(),
      ),
      GoRoute(
        path: '/payment-settings',
        builder: (context, state) => const PaymentSettingsPage(),
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) => const HelpPage(),
      ),
      GoRoute(
        path: '/faq',
        builder: (context, state) => const FaqPage(),
      ),
    ],
  );

  /// Opens Privacy Policy as a modal bottom sheet.
  static void showPrivacyPolicy(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const PrivacyPolicyPage(),
    );
  }

  /// Opens Terms & Conditions as a modal bottom sheet.
  static void showTerms(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const TermsPage(),
    );
  }
}
