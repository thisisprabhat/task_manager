import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/onboarding/onboarding.dart';
import '/presentation/screens/settings/settings.dart';
import '/core/constants/styles.dart';
import '/data/models/user_model.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const path = '/profile';
  static const routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.watch<AuthBloc>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(paddingDefault / 2),
              child: CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.person,
                  size: 44,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
              child: Text(
                user?.name ?? "Login",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
              child: Text(user?.email ?? 'To access remote database'),
            ),
            const SizedBox(height: 30),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.maxFinite),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 0),
                onPressed: () => context.pushNamed(SettingsScreen.routeName),
                child: const Text('Setting'),
              ),
            ),
            const SizedBox(height: 10),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateLogout) {
                  // Navigator.pushReplacementNamed(
                  //     context, OnboardingScreen.path);
                  context.goNamed(OnboardingScreen.routeName);
                }
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.maxFinite),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.error.withOpacity(0.2),
                    elevation: 0,
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogout());
                  },
                  child: const Text('Logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
