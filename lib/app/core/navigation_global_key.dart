import 'package:flutter/material.dart';

class NavigationGlobalKey {
  NavigationGlobalKey._();
  static NavigationGlobalKey? _instance;
  static NavigationGlobalKey get instance =>
      _instance ??= NavigationGlobalKey._();

  final navigationKey = GlobalKey<NavigatorState>();
}
