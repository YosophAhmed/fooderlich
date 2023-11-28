import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter {
  final AppStateManger appStateManger;
  final ProfileManger profileManger;
  final GroceryManger groceryManger;

  AppRouter(
    this.appStateManger,
    this.profileManger,
    this.groceryManger,
  );

  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: appStateManger,
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: 'home',
        path: '/:tab',
        builder: (context, state) {
          final tab = int.tryParse(state.pathParameters['tab'] ?? '') ?? 0;
          return Home(
            key: state.pageKey,
            currentTab: tab,
          );
        },
        routes: [],
      ),
    ],
    redirect: (context, state) {
      final loggedIn = appStateManger.isLoggedIn;
      final loggingIn = state.fullPath == '/login';

      if (!loggedIn) {
        return loggingIn ? null : '/login';
      }

      final isOnBoardingComplete = appStateManger.isOnboardingComplete;
      final onboarding = state.fullPath == '/onboarding';

      if (!isOnBoardingComplete) {
        return onboarding ? null : '/onboarding';
      }
      if (loggingIn || onboarding) {
        return '/${FooderlichTab.explore}';
      }
      return null;
    },
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
  );
}
