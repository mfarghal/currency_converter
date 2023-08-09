import '../../domain/entities/history_item_entity.dart';
import 'conversion_rate_history_item_model.dart';

class HistoryItemModel extends HistoryItemEntity {
  const HistoryItemModel(
      {required super.to,
      required super.from,
      required super.conversionRateHistory});

  factory HistoryItemModel.fromJson(Map<String, dynamic> jsonMap) =>
      HistoryItemModel(
        from: jsonMap['from'],
        to: jsonMap['to'],
        conversionRateHistory: List<ConversionRateHistoryItemModel>.from(
          jsonMap['conversions_rate'].map(
            (e) => ConversionRateHistoryItemModel.fromJson(e),
          ),
        ),
      );
}
