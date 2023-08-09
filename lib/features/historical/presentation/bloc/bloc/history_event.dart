part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class RequestLast7DaysHistoryEvent extends HistoryEvent {
  final List<String> currencies;

  const RequestLast7DaysHistoryEvent(this.currencies);

  //
  @override
  List<Object> get props => [currencies];
}
