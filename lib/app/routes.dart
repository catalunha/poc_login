import 'package:flutter/material.dart';
import 'package:poc_login/app/pages/home/home_page.dart';
import 'package:poc_login/app/pages/login/login_page.dart';

import 'pages/splash/splash_page.dart';

enum AppRoute {
  home('/home'),
  login('/login'),
  splash('/');

  final String name;
  const AppRoute(this.name);
}

final routes = <String, Widget Function(BuildContext context)>{
  AppRoute.splash.name: (_) => const SplashPage(),
  AppRoute.login.name: (_) => const LoginPage(),
  AppRoute.home.name: (_) => const HomePage(),
};
