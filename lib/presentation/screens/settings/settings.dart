import 'package:flutter/material.dart';

import '/core/constants/styles.dart';
import '/presentation/screens/settings/components/theme_switcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const path = '/settings';
  static const routeName = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: borderRadiusDefault,
            ),
            child: ListTile(
              title: const Text("Theme"),
              leading: const Icon(Icons.dark_mode),
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return const SizedBox(height: 300, child: ThemeSwitcher());
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
