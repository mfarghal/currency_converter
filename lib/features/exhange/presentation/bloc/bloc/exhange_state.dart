part of 'exhange_bloc.dart';

sealed class ExhangeState extends Equatable {
  const ExhangeState();

  @override
  List<Object> get props => [];
}

final class ExhangeInitial extends ExhangeState {}

final class ExhangeLoading extends ExhangeState {}

final class ExhangeLoaded extends ExhangeState {
  final double rate;
  final double value;

  const ExhangeLoaded({required this.rate, required this.value});
}

final class ExhangeError extends ExhangeState {}
