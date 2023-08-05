import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/error/failure.dart';
import 'package:currency_converter_demo/features/currencies/data/datasources/currencies_local_data_source.dart';
import 'package:currency_converter_demo/features/currencies/data/datasources/currencies_remote_data_source.dart';
import 'package:currency_converter_demo/features/currencies/data/models/currency_model.dart';

import 'package:currency_converter_demo/features/currencies/data/repositories/currencies_repository_impl.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mo;
import 'currencies_repository_imp_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<CurrenciesLocalDataSource>(),
    MockSpec<CurrenciesRemoteDataSource>(),
  ],
)
void main() {
  group('currencies_repository_imp', () {
    group('local storage is empty', () {
      final localDataSource = MockCurrenciesLocalDataSource();
      setUp(() => mo
          .when(localDataSource.isEmptyLocalStorage)
          .thenAnswer((realInvocation) => Future.value(true)));

      test('should return locally data when the cached data is present',
          () async {
        // arrange
        final l = [const CurrencyModel(1), const CurrencyModel(1)];
        final remoteDataSource = MockCurrenciesRemoteDataSource();
        final repository =
            CurrenciesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(localDataSource.getCachedCurrencies())
            .thenAnswer((realInvocation) => Future.value(l));

        // act
        final res = await repository.getAvailableCurrencies();

        // assert
        mo.verify(localDataSource.getCachedCurrencies());
        mo.verifyZeroInteractions(remoteDataSource);
        expect(res, Right(l));
      });

      test('should return cache failure when call throw cache excpetion',
          () async {
        // arrange
        final remoteDataSource = MockCurrenciesRemoteDataSource();
        final repository =
            CurrenciesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(localDataSource.getCachedCurrencies())
            .thenThrow(CacheException());

        // act
        final res = await repository.getAvailableCurrencies();

        // assert
        mo.verify(localDataSource.getCachedCurrencies());
        mo.verifyZeroInteractions(remoteDataSource);
        expect(res, Left(CacheFailure()));
      });
    });

    group('local storage is not empty', () {
      final localDataSource = MockCurrenciesLocalDataSource();
      setUp(() => mo
          .when(localDataSource.isEmptyLocalStorage)
          .thenAnswer((realInvocation) => Future.value(false)));

      test(
          'should return remote data when call to remote data source is success',
          () async {
        final l = [const CurrencyModel(1), const CurrencyModel(2)];
        final remoteDataSource = MockCurrenciesRemoteDataSource();
        final repository =
            CurrenciesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(remoteDataSource.getCurrencies())
            .thenAnswer((realInvocation) => Future.value(l));

        // act
        final res = await repository.getAvailableCurrencies();

        // assert
        mo.verify(remoteDataSource.getCurrencies());
        expect(res, Right(l));
      });

      test(
          'should cache data locally when call to remote data source successed',
          () async {
        // arrange
        final l = [const CurrencyModel(1), const CurrencyModel(2)];
        final remoteDataSource = MockCurrenciesRemoteDataSource();
        final repository =
            CurrenciesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(remoteDataSource.getCurrencies())
            .thenAnswer((realInvocation) => Future.value(l));

        // act
        final _ = await repository.getAvailableCurrencies();

        // assert
        mo.verify(localDataSource.cacheCurrencies(l));
      });

      test(
          'should return server failure when the call to remote data source unsuccessful',
          () async {
        // arrange
        final remoteDataSource = MockCurrenciesRemoteDataSource();
        final repository =
            CurrenciesRepositoryImp(localDataSource, remoteDataSource);
        mo.when(remoteDataSource.getCurrencies()).thenThrow(ServerException());

        // act
        final res = await repository.getAvailableCurrencies();

        // assert

        mo.verify(remoteDataSource.getCurrencies());
        mo.verifyNever(localDataSource.cacheCurrencies(mo.any));
        expect(res, Left(ServerFailure()));
      });
    });
  });
}
