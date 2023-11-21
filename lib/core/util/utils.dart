import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moriko/config/config.dart';

var logger = Logger();
final Widget shimmer = Animate(
  onComplete: (c) => c.repeat(),
).shimmer(
  colors: [
    Colors.black12,
    white,
    Colors.black12,
  ],
);

class Shimmer extends StatelessWidget {
  final Widget child;
  const Shimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
      onComplete: (c) => c.repeat(),
      child: child,
    ).shimmer(
      duration: 3.seconds,
      color: Colors.grey,
      colors: [
        Colors.black12,
        Colors.white30,
        Colors.black12,
        Colors.white30,
        Colors.black12,
      ],
    );
  }
}
