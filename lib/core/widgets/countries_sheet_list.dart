import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/countries/presentation/bloc/countries_bloc.dart';
import '../constants/app/app_constants.dart';

class CountriesSheetList extends StatelessWidget {
  const CountriesSheetList({super.key});

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

  Widget _errorMessage(BuildContext context) => Center(
        child: Text(
          'oops ,Something wrong',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.red),
        ),
      );

  Widget _list(CountriesLoaded state) => ListView.builder(
        itemCount: state.list.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.of(context).pop(state.list[index]),
          child: ListTile(
            key: ValueKey(state.list[index].id),
            leading: SizedBox(
              width: 16,
              height: 12,
              child: CachedNetworkImage(
                imageUrl: ApplicationConstants.flagUrl(
                    countyrId: state.list[index].id),
              ),
            ),
            title: Text(
              state.list[index].name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      );

  Widget _loading() => const Center(child: CircularProgressIndicator());
}
