import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter_demo/features/countries/domain/entities/country_entity.dart';
import 'package:currency_converter_demo/features/historical/presentation/bloc/bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/widgets/countries_sheet_list.dart';

class SelectCurrencies extends StatefulWidget {
  const SelectCurrencies({super.key});

  @override
  State<SelectCurrencies> createState() => _SelectCurrenciesState();
}

class _SelectCurrenciesState extends State<SelectCurrencies> {
  CountryEntity? _first;
  CountryEntity? _second;

  Future<CountryEntity?> _modalBottomSheetMenu(BuildContext context) async =>
      showModalBottomSheet<CountryEntity?>(
        context: context,
        builder: (builder) => Container(
          height: MediaQuery.sizeOf(context).height * 0.7,
          color: Colors.transparent,
          child: const SafeArea(child: CountriesSheetList()),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        children: [
          _action(
            title: 'Select First Currency',
            country: _first,
            onPressed: () async {
              final val = await _modalBottomSheetMenu(context);
              setState(() => _first = val);
            },
          ),
          _action(
            title: 'Select Second Currency',
            country: _second,
            onPressed: () async {
              final val = await _modalBottomSheetMenu(context);
              setState(() => _second = val);
            },
          ),
          OutlinedButton(
            onPressed: () => context.read<HistoryBloc>().add(
                RequestLast7DaysHistoryEvent(
                    [_first?.currencyId ?? '', _second?.currencyId ?? ''])),
            child: Text(
              'LOAD',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        ],
      ),
    );
  }

  _action({
    required String title,
    required CountryEntity? country,
    required Function() onPressed,
  }) =>
      Row(
        children: [
          Container(
            width: 56,
            height: 45,
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: country == null
                ? const SizedBox.shrink()
                : CachedNetworkImage(
                    imageUrl:
                        ApplicationConstants.flagUrl(countyrId: country.id),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          )
        ],
      );
}
