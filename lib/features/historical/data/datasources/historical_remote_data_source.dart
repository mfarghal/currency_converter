import '../models/history_item_model.dart';

abstract class HistoricalRemoteDataSource {
  Future<List<HistoryItemModel>> getHistoryForLast7Days();
}
