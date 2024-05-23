import 'package:cashier_app/commons/widgets/navbar/bottom_navbar_scaffold.dart';
import 'package:cashier_app/modules/authentication/screens/login/login.dart';
import 'package:cashier_app/modules/authentication/screens/onboarding/onboarding.dart';
import 'package:cashier_app/modules/authentication/screens/register/register.dart';
import 'package:cashier_app/modules/dashboard/dashboard_screen.dart';
import 'package:cashier_app/modules/master_data/products/product_list_screen.dart';
import 'package:cashier_app/modules/profile/screen/profile_screen.dart';
import 'package:cashier_app/modules/splash/screens/splash.dart';
import 'package:cashier_app/modules/transactions/cart/screen/cart_screen.dart';
import 'package:cashier_app/modules/transactions/receipts/sales_list_screen.dart';
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
      builder: (context, state) => const OnboardingScreen(),
    ),

    // private
    GoRoute(
      path: "/cart",
      builder: (context, state) => const CartScreen(),
    ),

    // route with navbar bottom
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(
          child,
          key: state.pageKey,
        );
      },
      routes: [
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
            path: "/productList",
            builder: (context, state) => const ProductListScreen()),
        GoRoute(
          path: "/transaction",
          builder: (context, state) => const SalesListScreen(),
        ),
        GoRoute(
          name: "home",
          path: '/home/:username',
          pageBuilder: (context, state) {
            final username = state.pathParameters['username'] ?? '';
            return NoTransitionPage(
              child: CashierHomePage(
                title: username,
                key: state.pageKey,
              ),
            );
          },
        ),
      ],
    )
  ],
);
