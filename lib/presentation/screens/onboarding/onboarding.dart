import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '/presentation/widgets/loader.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import '/presentation/screens/authentication/login.dart';
import '/core/constants/app_assets.dart';
import '/core/constants/app_constants.dart';
import '/core/constants/styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const String route = '/onboarding';
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventCheckLoggedInUser());
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateAlreadyLoggedIn) {
              Navigator.pushReplacementNamed(context, HomeScreen.route);
            }
          },
          builder: (context, state) {
            if (state is AuthStateNoUserFound) {
              return _onboardingWidget(context);
            } else {
              return const Loader();
            }
          },
        ),
      ),
    );
  }

  Widget _onboardingWidget(context) => Padding(
        padding: const EdgeInsets.all(paddingDefault),
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(AppAssets.onboardingAnimation),
            ),
            const Text(
              'Welcome to ${AppConstant.appName}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),
            const SizedBox(height: 10),
            const Text(
              'Manage your tasks with ease',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            const SizedBox(height: 100),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.maxFinite),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Login.route);
                },
                child: const Text("Get Started"),
              ),
            )
          ],
        ),
      );
}
