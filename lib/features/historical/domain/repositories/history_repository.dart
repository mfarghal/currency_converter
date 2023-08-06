import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/history_item_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<HistoryItemEntity>>> getLast7Days(
      List<String> currencies);
}
