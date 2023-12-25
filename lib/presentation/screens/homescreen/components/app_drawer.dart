import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/profile/profile_screen.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/data/models/user_model.dart';
import '/core/constants/styles.dart';
import '/presentation/screens/settings/components/theme_switcher.dart';
import '/presentation/screens/settings/settings.dart';
import '/presentation/screens/onboarding/onboarding.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.watch<AuthBloc>().user;
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: paddingDefault),
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
            const Divider(height: paddingDefault),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: const Text("Home"),
                        leading: const Icon(Icons.home),
                        onTap: () {
                          // Navigator.pushNamed(context, HomeScreen.path);
                          context.pop();
                          context.goNamed(HomeScreen.routeName);
                        },
                      ),
                      ListTile(
                        title: const Text("Settings"),
                        leading: const Icon(Icons.settings),
                        onTap: () {
                          // Navigator.pushNamed(context, SettingsScreen.path);
                          context.pop();
                          context.pushNamed(SettingsScreen.routeName);
                        },
                      ),
                      ListTile(
                        title: const Text("Profile"),
                        leading: const Icon(Icons.person),
                        onTap: () {
                          // Navigator.pushNamed(context, ProfileScreen.path);
                          context.pop();
                          context.goNamed(ProfileScreen.routeName);
                        },
                      ),
                      ListTile(
                        title: const Text("Theme"),
                        leading: const Icon(Icons.dark_mode),
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return const SizedBox(
                                  height: 300, child: ThemeSwitcher());
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthStateLogout) {
                  // Navigator.pushReplacementNamed(
                  //     context, OnboardingScreen.path);
                  context.goNamed(OnboardingScreen.routeName);
                }
              },
              child: ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.logout),
                onTap: () => context.read<AuthBloc>().add(AuthEventLogout()),
              ),
            ),
            const SizedBox(height: paddingDefault)
          ],
        ),
      ),
    );
  }
}
