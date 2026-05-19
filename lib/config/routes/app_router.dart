import 'package:go_router/go_router.dart';
import 'package:mrt_clone/features/auth/presentation/pages/onboarding_page.dart';
import 'package:mrt_clone/features/auth/presentation/pages/login_page.dart';
import 'package:mrt_clone/features/auth/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}
