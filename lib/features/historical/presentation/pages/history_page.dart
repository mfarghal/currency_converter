import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc/history_bloc.dart';
import 'components/body.dart';

class _HistoryPageWrapperProvider extends StatelessWidget {
  const _HistoryPageWrapperProvider();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HistoryBloc>(),
      child: const HistoryPage(),
    );
  }
}

class HistoryPage extends StatelessWidget {
  static const routeName = '/history';
  const HistoryPage({super.key});

  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(arguments: routeName),
        builder: (context) => const _HistoryPageWrapperProvider(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        title: Text(
          'History',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: const SafeArea(
        child: Body(),
      ),
    );
  }
}
