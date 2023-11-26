import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moriko/config/routes/typed_route.dart';
import 'package:moriko/features/shared/provider/navigation_bar.dart';

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
          icon: Icon(Icons.book_sharp),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(Icons.home_filled),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.more_horiz_outlined),
          label: 'More',
        )
      ],
    );
  }
}
