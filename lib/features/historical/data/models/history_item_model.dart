import 'package:currency_converter_demo/features/historical/domain/entities/history_item_entity.dart';

class HistoryItemModel extends HistoryItemEntity {
  const HistoryItemModel(super.id);

  factory HistoryItemModel.fromJson(Map<String, dynamic> jsonMap) =>
      HistoryItemModel(
        jsonMap['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
