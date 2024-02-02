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
      3000.milliseconds,
      () => HomeScreenRoute().pushReplacement(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 150),
          duration: 1500.milliseconds,
          builder: (context, value, child) {
            return SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Assets.icons.game.image(
                      width: value,
                      height: value,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Visibility(
                    visible: value >= 150,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'MORIKO',
                        style: poppins(
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 1000.milliseconds),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
