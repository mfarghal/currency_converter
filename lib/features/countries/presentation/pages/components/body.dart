import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/countries_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is CountriesLoading) {
            return _loading();
          } else if (state is CountriesLoaded) {
            return _list(state);
          } else if (state is CountriesError) {
            return _errorMessage(context);
          } else {
            return const SizedBox.shrink();
          }
        },
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

  Widget _list(CountriesLoaded state) => Expanded(
        child: ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (context, index) => Card(
            child: Center(
              child: Text(
                state.list[index].name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
      );

  Widget _loading() =>
      const Expanded(child: Center(child: CircularProgressIndicator()));
}
