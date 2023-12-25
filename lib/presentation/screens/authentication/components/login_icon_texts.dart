part of '../login.dart';

class LoginIconAndTexts extends StatelessWidget {
  const LoginIconAndTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        right: 60,
        top: 20,
        bottom: 30,
      ),
      child: Column(
        children: [
          Hero(
            tag: 'onboardingAsset',
            child: Lottie.asset(
              AppAssets.onboardingAnimation,
              height: 250,
              width: 250,
            ),
          ),
          const Text(
            'Task Manager',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Track your daily tasks and manage them easily',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
