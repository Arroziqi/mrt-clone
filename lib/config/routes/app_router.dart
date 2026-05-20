import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/ticket/presentation/pages/buy_ticket_page.dart';
import '../../features/ticket/presentation/pages/schedule_page.dart';
import '../../features/ticket/presentation/pages/payment_page.dart';
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
        path: '/buy-ticket',
        builder: (context, state) => const BuyTicketPage(),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const SchedulePage(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentPage(),
      ),
    ],
  );
}
