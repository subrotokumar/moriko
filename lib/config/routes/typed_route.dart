import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moriko/features/chapters/presentation/screen/chapters_screen.dart';

import 'package:moriko/features/search/presentation/screen/search_screen.dart';
import 'package:moriko/features/splash/presentation/screen/splash_screen.dart';
import 'package:moriko/model/searched_manga_res.dart';

part 'typed_route.g.dart';

@TypedGoRoute<SplashScreenRoute>(path: '/splash', name: 'splash')
class SplashScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SplashScreen();
}

@TypedGoRoute<SearchScreenRoute>(path: '/search', name: 'search')
class SearchScreenRoute extends GoRouteData {
  @override
  Widget build(context, state) => const SearchScreen();
}

@TypedGoRoute<ChaptersScreenRoute>(path: '/chapters', name: 'chapters')
class ChaptersScreenRoute extends GoRouteData {
  final SearchedManga $extra;
  ChaptersScreenRoute(this.$extra);

  @override
  Widget build(context, state) => ChaptersScreen($extra);
}
