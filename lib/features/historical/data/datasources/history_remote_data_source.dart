import '../models/history_item_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryItemModel>> getHistoryForLast7Days(
      List<String> currencies);
}
