import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import screens
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/coil/coil_screen.dart';
import '../../presentation/screens/location/location_screen.dart';
import '../../presentation/screens/shipment/shipment_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
// Import providers
import '../../data/providers/auth_provider.dart';
import '../../data/models/auth/session_model.dart';

// Create a splash screen for initial loading
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('SeAH Steel PDA 로딩 중...'),
          ],
        ),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final currentPath = state.uri.path;
      
      print('Router redirect: path=$currentPath, authState=${authState.toString()}'); // Debug log
      
      return authState.when(
        loading: () {
          print('Auth loading - staying on current path or going to splash');
          // While loading, show splash if not already there or on login
          if (currentPath != '/splash' && currentPath != '/login') {
            return '/splash';
          }
          return null;
        },
        error: (error, stack) {
          print('Auth error: $error - redirecting to login');
          // On error, redirect to login
          if (currentPath != '/login') {
            return '/login';
          }
          return null;
        },
        data: (session) {
          final isLoggedIn = session != null;
          print('Auth data: isLoggedIn=$isLoggedIn, session=${session?.user.userId}');
          
          if (isLoggedIn) {
            // User is logged in - redirect to home if on login/splash
            if (currentPath == '/login' || currentPath == '/splash') {
              print('Redirecting to home');
              return '/';
            }
          } else {
            // User is not logged in - redirect to login if not already there
            if (currentPath != '/login' && currentPath != '/splash') {
              print('Redirecting to login');
              return '/login';
            }
          }
          
          return null;
        },
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/coil',
        name: 'coil',
        builder: (context, state) => const CoilScreen(),
      ),
      GoRoute(
        path: '/location',
        name: 'location',
        builder: (context, state) => const LocationScreen(),
      ),
      GoRoute(
        path: '/shipment',
        name: 'shipment',
        builder: (context, state) => const ShipmentScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Error'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${state.uri}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Error: ${state.error}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('홈으로 돌아가기'),
            ),
          ],
        ),
      ),
    ),
  );

  // Listen to auth state changes and refresh router
  ref.listen<AsyncValue<SessionModel?>>(authStateProvider, (previous, next) {
    print('Auth state changed: ${previous.toString()} -> ${next.toString()}');
    router.refresh();
  });

  return router;
});
