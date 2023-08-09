import 'package:equatable/equatable.dart';

class ConversionRateHistoryItemEntity extends Equatable {
  final String date;
  final double val;

  const ConversionRateHistoryItemEntity(
      {required this.date, required this.val});

  @override
  List<Object?> get props => [date, val];
}
