import 'package:flutter/material.dart';

import '/presentation/screens/authentication/login.dart';
import '/presentation/screens/authentication/signup.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import '/presentation/screens/onboarding/onboarding.dart';

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case OnboardingScreen.route:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Login.route:
        return MaterialPageRoute(builder: (_) => const Login());
      case Signup.route:
        return MaterialPageRoute(builder: (_) => const Signup());

      default:
        return null;
    }
  }
}
