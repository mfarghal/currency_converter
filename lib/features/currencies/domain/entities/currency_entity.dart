import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final int id;

  const CurrencyEntity(this.id);
  @override
  List<Object?> get props => [id];
}
