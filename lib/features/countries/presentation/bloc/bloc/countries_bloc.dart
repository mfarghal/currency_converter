import 'package:currency_converter_demo/core/usecases/usecase.dart';
import 'package:currency_converter_demo/features/countries/domain/usecases/get_available_countries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/country_entity.dart';
part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetAvailableCountries getAvailableCountriesUseCase;

  CountriesBloc({
    required this.getAvailableCountriesUseCase,
  }) : super(CountriesInitial()) {
    on<RequestAllAvaliableCountriesEvent>((event, emit) async {
      emit(CountriesLoading());

      final res = await getAvailableCountriesUseCase(NoParams());
      res.fold(
        (l) => emit(CountriesError()),
        (r) => emit(CountriesLoaded(r)),
      );
    });
  }
}
