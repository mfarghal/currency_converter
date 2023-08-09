import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/history_item_entity.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_data_source.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<HistoryItemEntity>>> getHistoryForDateRange(
      String from, String to, List<String> q) async {
    try {
      final list = await remoteDataSource.getHistoryForDateRange(from, to, q);
      return Right(list);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } catch (e) {
      log('$e');
      return Left(GeneralFailure());
    }
  }
}
