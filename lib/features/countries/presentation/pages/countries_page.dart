import 'package:flutter/material.dart';

import '../../../exhange/presentation/pages/exhange_page.dart';
import 'components/body.dart';

class CountriesPage extends StatelessWidget {
  static const routeName = '/';
  //
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(arguments: routeName),
        builder: (context) => const CountriesPage(),
      );
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        title: Text(
          'Avaliable Currencies',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: const SafeArea(
        child: Body(),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Navigator.of(context).pushNamed(ExhangePage.routeName),
        child: const Icon(Icons.price_change),
      ),
    );
  }
}
