import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/history_bloc.dart';
import '../../widgets/conversion_rate_history.dart';
import '../../widgets/select_currencies.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SelectCurrencies(),
          BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return _loading();
              } else if (state is HistoryLoaded) {
                return _list(state);
              } else if (state is HistoryError) {
                return _errorMessage(context);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      );

  Widget _errorMessage(BuildContext context) => Expanded(
        child: Center(
          child: Text(
            'oops ,Something wrong',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.red),
          ),
        ),
      );

  Widget _list(HistoryLoaded state) => Expanded(
        child: ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) => ListTile(
            key: ValueKey(index),
            title: Text(
              '${state.list[index].from} -> ${state.list[index].to}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: ConversionRateHistory(
              details: state.list[index].conversionRateHistory,
            ),
          ),
        ),
      );

  Widget _loading() =>
      const Expanded(child: Center(child: CircularProgressIndicator()));
}
