import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/search/search_page.dart';
import '/presentation/screens/main_page/main_page.dart';
import '/presentation/screens/settings/settings.dart';
import '/presentation/screens/profile/profile_screen.dart';
import '/presentation/screens/authentication/login.dart';
import '/presentation/screens/authentication/signup.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import '/presentation/screens/onboarding/onboarding.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: OnboardingScreen.routeName,
        path: OnboardingScreen.path,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: OnboardingScreen(),
          );
        },
      ),
      GoRoute(
        name: Login.routeName,
        path: Login.path,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: Login(),
          );
        },
      ),
      GoRoute(
        name: Signup.routeName,
        path: Signup.path,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: Signup(),
          );
        },
      ),
      GoRoute(
        name: SettingsScreen.routeName,
        path: SettingsScreen.path,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SettingsScreen(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: HomeScreen.routeName,
            path: HomeScreen.path,
            pageBuilder: (context, state) {
              return const MaterialPage(child: HomeScreen());
            },
          ),
          GoRoute(
            name: SearchPage.routeName,
            path: SearchPage.path,
            pageBuilder: (context, state) {
              return const MaterialPage(child: SearchPage());
            },
          ),
          GoRoute(
            name: ProfileScreen.routeName,
            path: ProfileScreen.path,
            pageBuilder: (context, state) {
              return const MaterialPage(child: ProfileScreen());
            },
          ),
        ],
      ),
    ],
  );

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.path:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(), settings: settings);
      case OnboardingScreen.path:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Login.path:
        return MaterialPageRoute(builder: (_) => const Login());
      case Signup.path:
        return MaterialPageRoute(builder: (_) => const Signup());
      case SettingsScreen.path:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case ProfileScreen.path:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return null;
    }
  }
}
