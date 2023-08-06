import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/history_item_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<HistoryItemEntity>>> getLast7Days(
      List<String> currencies) async {
    try {
      final list = await remoteDataSource.getHistoryForLast7Days(currencies);
      return Right(list);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } catch (_) {
      return Left(GeneralFailure());
    }
  }
}
