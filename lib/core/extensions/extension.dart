import 'package:flutter/material.dart';

extension BuildCOntextX on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  Size get getSize => MediaQuery.of(this).size;
  double get height => getSize.height;
  double get width => getSize.height;
  ThemeData get theme => Theme.of(this);
  void removeFocus() => FocusScope.of(this).requestFocus();
  NavigatorState get navigator => Navigator.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}
