import 'package:cashier_app/modules/authentication/screens/login/login.dart';
import 'package:cashier_app/modules/authentication/screens/onboarding/onboarding.dart';
import 'package:cashier_app/modules/authentication/screens/register/register.dart';
import 'package:cashier_app/modules/dashboard/dashboard_screen.dart';
import 'package:cashier_app/modules/master_data/products/product_list_screen.dart';
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
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
        path: "/onboarding",
        builder: (context, state) => const OnboardingScreen()),
    GoRoute(
        path: "/productList",
        builder: (context, state) => const ProductListScreen()),
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
