part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  final List<HistoryItemEntity> list;

  const HistoryLoaded(this.list);

  //
  @override
  List<Object> get props => [list];
}

final class HistoryError extends HistoryState {}
