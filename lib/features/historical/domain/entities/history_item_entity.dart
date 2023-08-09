import 'package:equatable/equatable.dart';

import 'conversion_rate_history_item_entity.dart';

class HistoryItemEntity extends Equatable {
  final String to;
  final String from;

  final List<ConversionRateHistoryItemEntity> conversionRateHistory;

  const HistoryItemEntity({
    required this.to,
    required this.from,
    required this.conversionRateHistory,
  });

  //
  @override
  List<Object?> get props => [to, from, conversionRateHistory];
}
