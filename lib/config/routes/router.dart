import 'package:moriko/config/routes/typed_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) => GoRouter(
      debugLogDiagnostics: true,
      initialLocation: SplashScreenRoute().location,
      routes: $appRoutes,
    );
