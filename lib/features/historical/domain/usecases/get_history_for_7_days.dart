import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/history_item_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetHistoryFor7Days extends UseCase<HistoryItemEntity, Params> {
  @override
  Future<Either<Failure, HistoryItemEntity>> call(Params params) {
    throw UnimplementedError();
  }
}

class Params extends Equatable {
  final List<String> currencies;

  //
  const Params(this.currencies);

  @override
  List<Object?> get props => [currencies];
}
