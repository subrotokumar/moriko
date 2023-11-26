import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moriko/features/chapters/presentation/screen/chapters_screen.dart';
import 'package:moriko/features/home/presentaion/screen/home_screen.dart';
import 'package:moriko/features/library/presentation/library_screen.dart';
import 'package:moriko/features/more/presentation/screen/more_screen.dart';

import 'package:moriko/features/search/presentation/screen/search_screen.dart';
import 'package:moriko/features/splash/presentation/screen/splash_screen.dart';
import 'package:moriko/model/searched_manga_res.dart';

part 'typed_route.g.dart';

@TypedGoRoute<SplashScreenRoute>(path: '/splash', name: 'splash')
class SplashScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SplashScreen();
}

@TypedGoRoute<HomeScreenRoute>(path: "/", name: "home")
class HomeScreenRoute extends GoRouteData {
  @override
  CustomTransitionPage<void> buildPage(
          BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, animation2, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<LibraryScreenRoute>(path: "/library", name: "library")
class LibraryScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const LibraryScreen();
}

@TypedGoRoute<SearchScreenRoute>(path: '/search', name: 'search')
class SearchScreenRoute extends GoRouteData {
  @override
  CustomTransitionPage<void> buildPage(
          BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: const SearchScreen(),
        transitionsBuilder: (context, animation, animation2, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<MoreScreenRoute>(path: '/more', name: 'more')
class MoreScreenRoute extends GoRouteData {
  @override
  CustomTransitionPage<void> buildPage(
          BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: const MoreScreen(),
        transitionsBuilder: (context, animation, animation2, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

@TypedGoRoute<ChaptersScreenRoute>(path: '/chapters', name: 'chapters')
class ChaptersScreenRoute extends GoRouteData {
  final SearchedManga $extra;
  ChaptersScreenRoute(this.$extra);

  @override
  Widget build(context, state) => ChaptersScreen($extra);
}
