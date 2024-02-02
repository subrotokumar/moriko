import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/routes/typed_route.dart';
import 'package:moriko/features/shared/provider/navigation_bar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navBar = ref.watch(navBarProvider);
    return NavigationBar(
      height: 65,
      selectedIndex: navBar,
      onDestinationSelected: (index) {
        if (navBar == index) return;
        ref.read(navBarProvider.notifier).changeVal(index);
        switch (index) {
          case 0:
            SearchScreenRoute().pushReplacement(context);
            break;
          case 1:
            HomeScreenRoute().pushReplacement(context);
            break;
          case 2:
            MoreScreenRoute().pushReplacement(context);
            break;
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.magnifyingGlass),
          selectedIcon: Icon(PhosphorIconsFill.magnifyingGlass),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.atom),
          selectedIcon: Icon(PhosphorIconsFill.atom),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(PhosphorIconsRegular.squaresFour),
          selectedIcon: Icon(PhosphorIconsFill.squaresFour),
          label: 'More',
        )
      ],
    );
  }
}
