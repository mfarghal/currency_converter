import 'package:currency_converter_demo/features/countries/presentation/bloc/bloc/countries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import 'components/body.dart';

class _CountriesPageWrapperProvider extends StatelessWidget {
  const _CountriesPageWrapperProvider();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CountriesBloc>()..add(RequestAllAvaliableCountriesEvent()),
      child: const CountriesPage(),
    );
  }
}

class CountriesPage extends StatelessWidget {
  static const routeName = '/countries';
  //
  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(arguments: routeName),
        builder: (context) => const _CountriesPageWrapperProvider(),
      );
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
