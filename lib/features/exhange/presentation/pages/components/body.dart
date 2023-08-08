import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../core/constants/app/app_constants.dart';
import '../../../../countries/domain/entities/country_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/exhange_bloc.dart';
import '../../widgets/countries_sheet_list.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ///
  CountryEntity? _to;
  CountryEntity? _from;

  //
  TextEditingController? controller;

  ///
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  ///
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  ///
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          _fromWidget(context),
          const SizedBox(height: 12),
          _toWidget(context),
          const SizedBox(height: 24),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () => _startConvert(context),
            child: Text(
              'CONVERT',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        ],
      ),
    );
  }

  void _startConvert(BuildContext context) {
    context.read<ExhangeBloc>().add(
          ConvertNumberExhangeEvent(
            val: controller?.text ?? '',
            toCurrencyId: _to?.currencyId ?? '',
            fromCurrencyId: _from?.currencyId ?? '',
          ),
        );
  }

  Widget _toWidget(BuildContext context) => Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              final val = await _modalBottomSheetMenu(context);
              setState(() => _to = val);
            },
            child: Row(
              children: [
                if (_to != null)
                  CachedNetworkImage(
                    imageUrl:
                        ApplicationConstants.flagUrl(countyrId: _to?.id ?? ''),
                  ),
                if (_to != null) const SizedBox(width: 12),
                Text(
                  'to',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              child: BlocBuilder<ExhangeBloc, ExhangeState>(
                builder: (context, state) {
                  if (state is ExhangeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ExhangeLoaded) {
                    return Column(
                      children: [
                        Text(
                          '${state.value}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Rate: ${state.rate}',
                          textAlign: TextAlign.right,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                        )
                      ],
                    );
                  } else {
                    return Text(
                      '0',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                          ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      );

  Widget _fromWidget(BuildContext context) => Row(
        children: [
          ElevatedButton(
            onPressed: () async {
              final val = await _modalBottomSheetMenu(context);
              setState(() => _from = val);
            },
            child: Row(
              children: [
                if (_from != null)
                  CachedNetworkImage(
                    imageUrl: ApplicationConstants.flagUrl(
                        countyrId: _from?.id ?? ''),
                  ),
                if (_from != null) const SizedBox(width: 12),
                Text(
                  'from',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          )
        ],
      );
}
