import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/exhange_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _from(context),
        _to(context),
        OutlinedButton(
          onPressed: () => _startConvert(context),
          child: Text(
            'CONVERT',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }

  void _startConvert(BuildContext context) => context.read<ExhangeBloc>().add(
        const ConvertNumberExhangeEvent(
          val: 2,
          fromCurrencyId: 'fromCurrencyId',
          toCurrencyId: 'toCurrencyId',
        ),
      );

  Widget _to(BuildContext context) => Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'to',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(child: BlocBuilder<ExhangeBloc, ExhangeState>(
            builder: (context, state) {
              if (state is ExhangeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExhangeLoaded) {
                return Column(
                  children: [
                    Text(
                      '${state.value}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${state.rate}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[300],
                          ),
                    )
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )),
        ],
      );

  Widget _from(BuildContext context) => Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'from',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      );
}
