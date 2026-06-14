import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/entities/auth_session.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/session_notifier.dart';
import '../../features/products/presentation/pages/products_page.dart';

class AppRoutes {
  AppRoutes._();

  static const login = 'login';
  static const products = 'products';

  static const loginPath = '/login';
  static const productsPath = '/products';
}

class _GoRouterRefreshNotifier extends ChangeNotifier {
  _GoRouterRefreshNotifier(Ref ref) {
    ref.listen<AsyncValue<AuthSession?>>(
      sessionNotifierProvider,
      (_, _) => notifyListeners(),
    );
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _GoRouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.loginPath,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final session = ref.read(sessionNotifierProvider);
      if (session.isLoading) return null;

      final isAuthenticated = session.value != null;
      final goingToLogin = state.matchedLocation == AppRoutes.loginPath;

      if (!isAuthenticated && !goingToLogin) return AppRoutes.loginPath;
      if (isAuthenticated && goingToLogin) return AppRoutes.productsPath;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.loginPath,
        name: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.productsPath,
        name: AppRoutes.products,
        builder: (context, state) => const ProductsPage(),
      ),
    ],
  );
});
