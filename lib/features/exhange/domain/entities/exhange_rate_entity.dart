import 'package:equatable/equatable.dart';

class ExhangeRateEntity extends Equatable {
  final double rate;

  const ExhangeRateEntity({required this.rate});
  @override
  List<Object?> get props => [rate];
}
