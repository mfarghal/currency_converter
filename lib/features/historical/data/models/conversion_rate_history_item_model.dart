import 'package:currency_converter_demo/features/historical/domain/entities/conversion_rate_history_item_entity.dart';

class ConversionRateHistoryItemModel extends ConversionRateHistoryItemEntity {
  const ConversionRateHistoryItemModel({
    required super.date,
    required super.val,
  });

  factory ConversionRateHistoryItemModel.fromJson(
          Map<String, dynamic> jsonMap) =>
      ConversionRateHistoryItemModel(
        date: jsonMap['date'],
        val: jsonMap['val'],
      );
}
