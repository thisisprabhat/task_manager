import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/presentation/screens/search/search_page.dart';
import '/presentation/screens/profile/profile_screen.dart';
import '/presentation/screens/homescreen/homescreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});
  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    String path = GoRouter.of(context).routeInformationProvider.value.uri.path;
    int currentPageIndex = path.contains(HomeScreen.routeName)
        ? 0
        : path.contains(ProfileScreen.routeName)
            ? 2
            : 1;
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              context.goNamed(HomeScreen.routeName);
              break;
            case 1:
              context.goNamed(SearchPage.routeName);
              break;
            case 2:
              context.goNamed(ProfileScreen.routeName);
              break;
            default:
              context.goNamed(HomeScreen.routeName);
          }
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
