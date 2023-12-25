import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/config_bloc/config_bloc.dart';

enum ThemeColor {
  dynamic,
  blue,
  green,
  purple,
  orange,
  brown,
  grey,
  black,
  lime,
  pink,
  creame,
  yellow,
  skyBlue,
}

getThemeColor(ThemeColor themeColor) {
  switch (themeColor) {
    case ThemeColor.blue:
      return Colors.blue;
    case ThemeColor.green:
      return Colors.green;
    case ThemeColor.purple:
      return Colors.purple;
    case ThemeColor.orange:
      return Colors.orange;
    case ThemeColor.brown:
      return Colors.brown;
    case ThemeColor.grey:
      return Colors.grey;
    case ThemeColor.black:
      return Colors.black;
    case ThemeColor.lime:
      return Colors.lime;
    case ThemeColor.pink:
      return Colors.pink;
    case ThemeColor.creame:
      return const Color.fromARGB(255, 245, 221, 148);
    case ThemeColor.yellow:
      return Colors.yellow;
    case ThemeColor.skyBlue:
      return const Color.fromARGB(255, 29, 204, 248);
    default:
      return Colors.blue;
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.watch<ConfigBloc>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            height: 100,
            child: SizedBox(
              height: 80,
              child: ListView(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollDirection: Axis.horizontal,
                children: List.generate(ThemeColor.values.length, (index) {
                  final themeColor = ThemeColor.values[index];
                  if (themeColor == ThemeColor.dynamic) {
                    return const SizedBox();
                  }
                  return ColorSelector(
                    circleColor: getThemeColor(themeColor),
                    themeColor: themeColor,
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          themeModeBox(
              context: context,
              boxThemeMode: ThemeMode.system,
              title: 'System',
              icon: Icons.phone_android,
              topLeft: 30,
              topRight: 30),
          themeModeBox(
              context: context,
              boxThemeMode: data.themeMode,
              isModetColorBox: true,
              title: 'System Material Colors',
              icon: Icons.dynamic_feed),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              themeModeBox(
                context: context,
                boxThemeMode: ThemeMode.light,
                title: 'Light Mode',
                icon: Icons.sunny,
                bottomLeft: 30,
              ),
              themeModeBox(
                context: context,
                boxThemeMode: ThemeMode.dark,
                title: 'Dark Mode',
                icon: Icons.dark_mode,
                bottomRight: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector(
      {Key? key, required this.circleColor, required this.themeColor})
      : super(key: key);

  final Color circleColor;
  final ThemeColor themeColor;

  @override
  Widget build(BuildContext context) {
    // var boxInactiveColor = Theme.of(context).colorScheme.surfaceVariant;
    return Row(
      children: [
        InkWell(
          onTap: () {
            context
                .read<ConfigBloc>()
                .add(ConfigThemeModeChangeEvent(themeColor: themeColor));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            height: 80,
            width: 60,
            decoration: BoxDecoration(
              // color: null,
              color: context.watch<ConfigBloc>().themeColor == themeColor
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface.withAlpha(65),
              // border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: circleColor,
                  border: Border.all(
                      color:
                          context.watch<ConfigBloc>().themeColor == themeColor
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.surfaceVariant),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }
}

Widget themeModeBox({
  required BuildContext context,
  String title = '',
  required ThemeMode boxThemeMode,
  IconData icon = Icons.settings,
  bool isModetColorBox = false,
  double topLeft = 5,
  double topRight = 5,
  double bottomLeft = 5,
  double bottomRight = 5,
}) {
  final providedBoxThemeStatus =
      isModetColorBox ? ThemeColor.dynamic : boxThemeMode;
  final boxThemeStatus = isModetColorBox
      ? context.watch<ConfigBloc>().themeColor
      : context.watch<ConfigBloc>().themeMode;

  print(
      boxThemeStatus); //#########################################################
  return Expanded(
      child: InkWell(
    onTap: () {
      isModetColorBox
          ? context
              .read<ConfigBloc>()
              .add(ConfigThemeModeChangeEvent(themeColor: ThemeColor.dynamic))
          : context
              .read<ConfigBloc>()
              .add(ConfigThemeModeChangeEvent(themeMode: boxThemeMode));
      print(boxThemeMode);
      print("Theme is feed to ConfigBloc: $boxThemeStatus");
      print(boxThemeStatus == boxThemeMode);
    },
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    ),
    child: Container(
      height: 60,
      margin: const EdgeInsets.all(2.5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: boxThemeStatus == providedBoxThemeStatus
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: boxThemeStatus == providedBoxThemeStatus
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  color: boxThemeStatus == providedBoxThemeStatus
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
    ),
  ));
}
