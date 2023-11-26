import 'package:flutter/widgets.dart';
import 'package:moriko/config/theme/colors.dart';
import 'package:moriko/core/core.dart';

class ShimmeringGridView extends StatelessWidget {
  const ShimmeringGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4 / 7,
          mainAxisSpacing: 25,
          crossAxisSpacing: 16,
        ),
        itemCount: 12,
        itemBuilder: (context, index) => Stack(
          children: [
            Positioned.fill(
              bottom: 40,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: grey.shade300,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.topLeft,
                child: Container(
                  height: 11,
                  width: 100,
                  color: grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
