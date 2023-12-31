import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/core.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    try {
      await ref.read(sharedPrefProvider.future);
      ref.read(sharedPrefProvider).requireValue;
    } catch (e) {
      logger.e(e);
    }
    Future.delayed(
      2.seconds,
      () => HomeScreenRoute().pushReplacement(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 250),
          duration: 4.seconds,
          builder: (context, value, child) =>
              Assets.meta.logo.image(width: value),
        ),
      ),
    );
  }
}
