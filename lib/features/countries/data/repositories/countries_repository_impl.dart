import 'package:currency_converter_demo/features/countries/data/datasources/remote/countries_remote_data_source.dart';
import 'package:currency_converter_demo/features/countries/data/models/country_model.dart';
import 'package:currency_converter_demo/features/countries/domain/repositories/countries_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/country_entity.dart';

import '../datasources/local/countries_local_data_source.dart';

class CountriesRepositoryImp extends CountriesRepository {
  final CountriesLocalDataSource localDataSource;
  final CountriesRemoteDataSource remoteDataSource;

  CountriesRepositoryImp({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<CountryEntity>>> getAvailableCountries() async {
    try {
      List<CountryModel> list = [];
      if (await localDataSource.isEmptyLocalStorage) {
        list = await remoteDataSource.getCountries();
        await localDataSource.cacheCountries(list);
      } else {
        list = await localDataSource.getCachedCountries();
      }
      return Right(list);
    } on CacheException catch (_) {
      return Left(CacheFailure());
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } catch (_) {
      return Left(GeneralFailure());
    }
  }
}
