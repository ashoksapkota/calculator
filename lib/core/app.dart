import 'package:calculator/core/routes/app_routes.dart';
import 'package:calculator/core/routes/app_routes.dart';
import 'package:calculator/core/themes/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      initialRoute: AppRoute.calcRoute,
      routes: AppRoute.getApplicationRoute(),
      theme : getApplicationTheme(),
    );
  }
}
