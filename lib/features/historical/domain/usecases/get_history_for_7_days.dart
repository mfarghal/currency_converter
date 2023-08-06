import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/history_item_entity.dart';
import '../repositories/history_repository.dart';

class GetHistoryFor7Days extends UseCase<List<HistoryItemEntity>, Params> {
  final HistoryRepository repository;

  GetHistoryFor7Days(this.repository);
  @override
  Future<Either<Failure, List<HistoryItemEntity>>> call(Params params) async =>
      repository.getLast7Days(params.currencies);
}

class Params extends Equatable {
  final List<String> currencies;

  //
  const Params(this.currencies);

  @override
  List<Object?> get props => [currencies];
}
