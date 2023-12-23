import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '/core/constants/app_assets.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppAssets.loaderAnimation,
          height: 90,
          width: 90,
        ),
      ),
    );
  }
}
