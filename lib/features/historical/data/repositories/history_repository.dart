import 'package:currency_converter_demo/core/error/failure.dart';

import 'package:currency_converter_demo/features/historical/domain/entities/history_item_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  @override
  Future<Either<Failure, List<HistoryItemEntity>>> getLast7Days(
      List<String> currencies) {
    throw UnimplementedError();
  }
}
