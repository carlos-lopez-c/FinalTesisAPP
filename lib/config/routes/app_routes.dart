import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:h_c_1/auth/presentation/screens/forward_password.dart';
import 'package:h_c_1/auth/presentation/screens/login_screen.dart';
import 'package:h_c_1/auth/presentation/screens/two_factor_screen.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/DetalleCitaCompletadaTR.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/DetalleCitaTR.dart';
import 'package:h_c_1/citas_medicTR/presentation/screens/HistorialCitasTR.dart';
import 'package:h_c_1/config/routes/app_router_notifier.dart';
import 'package:h_c_1/home/presentation/screens/ChangePasswordScreen.dart';
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
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/two-factor',
        builder: (context, state) => const TwoFactorScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const Changepasswordscreen(),
      ),
      GoRoute(
        path: '/historial-citas',
        builder: (context, state) => HistorialCitasTR(),
      ),
      GoRoute(
        path: '/detalle-cita',
        builder: (context, state) => DetalleCitaTr(),
      ),
      GoRoute(
        path: '/detalle-cita-completada',
        builder: (context, state) => DetalleCitaCompletadaTR(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.uri.path;
      final authStatus = goRouterNotifier.authStatus;
      if (authStatus == AuthStatus.requires2FA) {
        if (isGoingTo == '/two-factor') {
          return null;
        }
        return '/two-factor';
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/forgot-password' ||
            isGoingTo == '/reset-password/code' ||
            isGoingTo == '/reset-password/new-password' ||
            isGoingTo == '/two-factor') {
          return null;
        }
        print('Redirecting to /login');
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/splash' ||
            isGoingTo == '/forgot-password' ||
            isGoingTo == '/reset-password/code' ||
            isGoingTo == '/reset-password/new-password' ||
            isGoingTo == '/two-factor') {
          return '/';
        }
      }

      return null;
    },
  );
});
