import 'package:currency_converter_demo/features/exhange/presentation/bloc/bloc/exhange_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import 'components/body.dart';

class _ExhangePageWrapperProvider extends StatelessWidget {
  const _ExhangePageWrapperProvider();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExhangeBloc>(),
      child: const ExhangePage(),
    );
  }
}

class ExhangePage extends StatelessWidget {
  static const routeName = '/exhange';

  const ExhangePage({super.key});

  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(arguments: routeName),
        builder: (context) => const _ExhangePageWrapperProvider(),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Body(),
      ),
    );
  }
}
