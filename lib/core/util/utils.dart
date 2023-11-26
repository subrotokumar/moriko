import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moriko/config/config.dart';
import 'package:moriko/core/extensions/extension.dart';

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

String camelCaseToSentence(String input) {
  StringBuffer result = StringBuffer();

  for (int i = 0; i < input.length; i++) {
    // Check if the character is uppercase
    if (input[i].toUpperCase() == input[i]) {
      // Add a space before the uppercase letter
      result.write(' ');
    }

    // Add the current character to the result
    result.write(input[i]);
  }

  // Capitalize the first letter and remove leading/trailing spaces
  return result.toString().trim().capitalize();
}
