import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/core/core.dart';
import 'package:moriko/features/reader/provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReaderBottomNavBar extends ConsumerWidget {
  const ReaderBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final readerScrollDirection = ref.watch(readerScrollDirectionProvider);
    final bottomNavVisibilty = ref.watch(bottomNavVisibiltyProvider);
    final horizontalBoxFit = ref.watch(horizontalBoxFitProvider);
    return Visibility(
      visible: bottomNavVisibilty,
      replacement: Container(height: 0),
      child: Container(
        height: 50,
        color: theme.inputDecorationTheme.fillColor!.withOpacity(0.9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                ref.read(readerScrollDirectionProvider.notifier).toogle();
              },
              icon: Transform.rotate(
                angle: readerScrollDirection == Axis.horizontal ? pi * .5 : 0,
                child: const Icon(Icons.width_normal_outlined),
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) => [
                for (var item in [
                  BoxFit.fill,
                  BoxFit.contain,
                  BoxFit.fitHeight,
                  BoxFit.fitWidth
                ])
                  PopupMenuItem(
                    onTap: () =>
                        ref.read(horizontalBoxFitProvider.notifier).set(item),
                    child: Text(camelCaseToSentence(item.name)),
                  ),
              ],
              child: Icon(PhosphorIcons.squaresFour()),
            ),
            IconButton(
              onPressed: () =>
                  ref.read(horizontalBoxFitProvider.notifier).toogle(),
              icon: Transform.rotate(
                angle: horizontalBoxFit == BoxFit.fitHeight ? pi * .5 : 0,
                child: Icon(PhosphorIcons.frameCorners()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
