import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/auth/presentation/screens/change_password_screen.dart';
import 'package:h_c_1/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:h_c_1/auth/presentation/screens/forward_password.dart';
import 'package:h_c_1/auth/presentation/screens/login_screen.dart';
import 'package:h_c_1/auth/presentation/screens/verify_code_screen%20copy.dart';
import 'package:h_c_1/config/routes/app_router_notifier.dart';
import 'package:h_c_1/home/presentation/screens/HomeScreen.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen()),
      GoRoute(
        path: '/reset-password/code',
        builder: (context, state) => const VerifyCodeScreen(),
      ),
      GoRoute(
          path: '/reset-password/new-password',
          builder: (context, state) => const ChangePasswordScreen()),
    ],
    redirect: (context, state) {
      final isGoingTo = state.uri.path;
      final authStatus = goRouterNotifier.authStatus;

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/forgot-password' ||
            isGoingTo == '/reset-password/code' ||
            isGoingTo == '/reset-password/new-password') {
          return null;
        }
        print('Redirecting to /login');
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});
