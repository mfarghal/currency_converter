import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_convert_rate.dart';

part 'exhange_event.dart';
part 'exhange_state.dart';

class ExhangeBloc extends Bloc<ExhangeEvent, ExhangeState> {
  final GetConvertRate getConvertRate;
  ExhangeBloc({required this.getConvertRate}) : super(ExhangeInitial()) {
    on<ConvertNumberExhangeEvent>((event, emit) async {
      emit(ExhangeLoading());

      final conversionRate = await getConvertRate(
          const Params(toCurrencyId: 'USD', fromCurrencyId: 'PHP'));
      conversionRate.fold(
        (l) => emit(ExhangeError()),
        (r) {
          emit(ExhangeLoaded(rate: r.rate, value: event.val * r.rate));
        },
      );
    });
  }
}
