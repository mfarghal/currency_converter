import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/exhange_rate_entity.dart';
import '../../domain/repositories/exhange_repository.dart';
import '../datasources/exhange_remote_data_source.dart';

class ExhangeRepositoryImpl implements ExhangeRepository {
  final ExhangeRemoteDataSource remoteDataSource;

  ExhangeRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, ExhangeRateEntity>> getConvertRate(
      String fromCurrencyId, String toCurrencyId) async {
    try {
      final val = await remoteDataSource.getConversionRate(
          from: fromCurrencyId, to: toCurrencyId);

      return Right(val);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } catch (_) {
      return Left(GeneralFailure());
    }
  }
}
