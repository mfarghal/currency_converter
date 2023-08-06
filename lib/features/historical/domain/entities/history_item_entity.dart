import 'package:equatable/equatable.dart';

class HistoryItemEntity extends Equatable {
  final int id;

  const HistoryItemEntity(this.id);
  @override
  List<Object?> get props => [id];
}
