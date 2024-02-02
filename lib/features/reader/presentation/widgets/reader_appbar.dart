import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moriko/core/providers/provider.dart';
import 'package:moriko/features/reader/provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReaderAppBar extends StatelessWidget {
  const ReaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final visible = ref.watch(bottomNavVisibiltyProvider);
      final themeMode = ref.watch(currentThemeProvider);
      return GestureDetector(
        onTap: () => ref.read(bottomNavVisibiltyProvider.notifier).toogle(),
        child: Visibility(
          visible: visible,
          child: AppBar(
            backgroundColor: themeMode == ThemeMode.dark
                ? Colors.black.withOpacity(0.7)
                : Colors.white70,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(PhosphorIconsBold.arrowUpLeft),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIconsRegular.bookmarks),
              )
            ],
          ),
        ),
      );
    });
  }
}
