part of 'exhange_bloc.dart';

sealed class ExhangeEvent extends Equatable {
  const ExhangeEvent();

  @override
  List<Object> get props => [];
}

class ConvertNumberExhangeEvent extends ExhangeEvent {
  final double val;
  final String fromCurrencyId;
  final String toCurrencyId;

  const ConvertNumberExhangeEvent({
    required this.val,
    required this.fromCurrencyId,
    required this.toCurrencyId,
  });

  //
  @override
  List<Object> get props => [val, fromCurrencyId, toCurrencyId];
}
