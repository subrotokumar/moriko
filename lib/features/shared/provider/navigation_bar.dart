import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'navigation_bar.g.dart';

@Riverpod(keepAlive: true)
class NavBar extends _$NavBar {
  @override
  int build() => 1;

  void changeVal(int index) {
    state = index;
  }
}
