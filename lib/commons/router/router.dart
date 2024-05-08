import 'package:cashier_app/modules/authentication/screens/login/login.dart';
import 'package:cashier_app/modules/dashboard/dashboard_screen.dart';
import 'package:cashier_app/modules/splash/screens/splash.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home/:username',
      builder: (context, state) {
        final username = state.pathParameters['username'] ?? '';
        return CashierHomePage(
          title: username,
        );
      },
    ),
  ],
);
