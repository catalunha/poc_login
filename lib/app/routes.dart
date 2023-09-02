import 'package:flutter/material.dart';

import 'pages/splash/splash_page.dart';

enum Route {
  splash('/');

  final String name;
  const Route(this.name);
}

final routes = <String, Widget Function(BuildContext context)>{
  Route.splash.name: (_) => const SplashPage(),
};
