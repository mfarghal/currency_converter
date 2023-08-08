import 'package:flutter/material.dart';

import '../../../features/countries/presentation/pages/countries_page.dart';
import '../../../features/exhange/presentation/pages/exhange_page.dart';

class AppRouter {
  AppRouter._init();
  static final AppRouter _instance = AppRouter._init();
  static AppRouter get instance => _instance;

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case CountriesPage.routeName:
        return CountriesPage.route();
      case ExhangePage.routeName:
        return ExhangePage.route();

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('NotFoundNavigationWidget'),
              ),
            ),
          ),
        );
    }
  }
}
