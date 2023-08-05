import 'package:currency_converter_demo/features/currencies/data/datasources/currencies_remote_data_source.dart';
import 'package:currency_converter_demo/features/currencies/data/models/currency_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/repositories/currencies_repository.dart';
import '../datasources/currencies_local_data_source.dart';

class CurrenciesRepositoryImp extends CurrenciesRepository {
  final CurrenciesLocalDataSource localDataSource;
  final CurrenciesRemoteDataSource remoteDataSource;

  CurrenciesRepositoryImp(this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getAvailableCurrencies() async {
    List<CurrencyModel> list;
    try {
      list = await localDataSource.getCachedCurrencies();
      if (list.isNotEmpty) return Right(list);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    } catch (_) {
      return Left(GeneralFailure());
    }

    try {
      list = await remoteDataSource.getCurrencies();
      await localDataSource.cacheCurrencies(list);
      return Right(list);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } catch (_) {
      return Left(GeneralFailure());
    }
  }
}
