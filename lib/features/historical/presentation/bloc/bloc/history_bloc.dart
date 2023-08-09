import 'package:currency_converter_demo/features/historical/domain/entities/history_item_entity.dart';
import 'package:currency_converter_demo/features/historical/domain/usecases/get_history_for_7_days.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryFor7Days getHistoryFor7Days;
  HistoryBloc({
    required this.getHistoryFor7Days,
  }) : super(HistoryInitial()) {
    on<RequestLast7DaysHistoryEvent>((event, emit) async {
      emit(HistoryLoading());
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');

      //
      final from = formatter.format(now.subtract(const Duration(days: 7)));
      final to = formatter.format(now);

      final res = await getHistoryFor7Days(
        Params(
          date: from,
          endDate: to,
          currencies: [
            event.currencies.join('_'),
            event.currencies.reversed.toList().join('_'),
          ],
        ),
      );

      //
      res.fold(
        (l) => emit(HistoryError()),
        (r) => emit(HistoryLoaded(r)),
      );
    });
  }
}
