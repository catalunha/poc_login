import 'package:flutter/material.dart';
import 'package:poc_login/app/core/app_theme.dart';

import 'core/navigation_global_key.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      navigatorKey: NavigationGlobalKey.instance.navigationKey,
      routes: routes,
    );
  }
}
