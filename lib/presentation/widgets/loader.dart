import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/core/constants/app_assets.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final Color loaderColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Center(
        // because flutter web doesn't support blend mode properly
        child: kIsWeb
            ? Lottie.asset(
                AppAssets.loaderAnimation,
                height: 100,
                width: 100,
              )
            : ColorFiltered(
                colorFilter: ColorFilter.mode(loaderColor, BlendMode.modulate),
                child: Lottie.asset(
                  AppAssets.loaderAnimation,
                  height: 100,
                  width: 100,
                ),
              ),
      ),
    );
  }
}
