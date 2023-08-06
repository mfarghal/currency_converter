import 'dart:convert';

import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/error/failure.dart';
import 'package:currency_converter_demo/features/countries/data/datasources/countries_local_data_source.dart';
import 'package:currency_converter_demo/features/countries/data/datasources/countries_remote_data_source.dart';
import 'package:currency_converter_demo/features/countries/data/models/country_model.dart';
import 'package:currency_converter_demo/features/countries/data/repositories/countries_repository_impl.dart';

import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mo;
import '../../../../fixtures/fixture_reader.dart';
import 'countries_repository_imp_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<CountriesLocalDataSource>(),
    MockSpec<CountriesRemoteDataSource>(),
  ],
)
void main() {
  group('currencies_repository_imp', () {
    group('local storage is empty', () {
      final localDataSource = MockCountriesLocalDataSource();
      setUp(() => mo
          .when(localDataSource.isEmptyLocalStorage)
          .thenAnswer((realInvocation) => Future.value(true)));

      test('should return locally data when the cached data is present',
          () async {
        // arrange
        final l = [
          CountryModel.fromJson(json.decode(fixture('country.json'))),
        ];
        final remoteDataSource = MockCountriesRemoteDataSource();
        final repository =
            CountriesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(localDataSource.getCachedCountries())
            .thenAnswer((realInvocation) => Future.value(l));

        // act
        final res = await repository.getAvailableCountries();

        // assert
        mo.verify(localDataSource.getCachedCountries());
        mo.verifyZeroInteractions(remoteDataSource);
        expect(res, Right(l));
      });

      test('should return cache failure when call throw cache excpetion',
          () async {
        // arrange
        final remoteDataSource = MockCountriesRemoteDataSource();
        final repository =
            CountriesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(localDataSource.getCachedCountries())
            .thenThrow(CacheException());

        // act
        final res = await repository.getAvailableCountries();

        // assert
        mo.verify(localDataSource.getCachedCountries());
        mo.verifyZeroInteractions(remoteDataSource);
        expect(res, Left(CacheFailure()));
      });
    });

    group('local storage is not empty', () {
      final localDataSource = MockCountriesLocalDataSource();
      setUp(() => mo
          .when(localDataSource.isEmptyLocalStorage)
          .thenAnswer((realInvocation) => Future.value(false)));

      test(
          'should return remote data when call to remote data source is success',
          () async {
        final l = [
          CountryModel.fromJson(json.decode(fixture('country.json'))),
        ];
        final remoteDataSource = MockCountriesRemoteDataSource();
        final repository =
            CountriesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(remoteDataSource.getCountries())
            .thenAnswer((realInvocation) => Future.value(l));

        // act
        final res = await repository.getAvailableCountries();

        // assert
        mo.verify(remoteDataSource.getCountries());
        expect(res, Right(l));
      });

      test(
          'should cache data locally when call to remote data source successed',
          () async {
        // arrange
        final l = [
          CountryModel.fromJson(json.decode(fixture('country.json'))),
        ];
        final remoteDataSource = MockCountriesRemoteDataSource();
        final repository =
            CountriesRepositoryImp(localDataSource, remoteDataSource);
        mo
            .when(remoteDataSource.getCountries())
            .thenAnswer((realInvocation) => Future.value(l));

        // act
        final _ = await repository.getAvailableCountries();

        // assert
        mo.verify(localDataSource.cacheCountries(l));
      });

      test(
          'should return server failure when the call to remote data source unsuccessful',
          () async {
        // arrange
        final remoteDataSource = MockCountriesRemoteDataSource();
        final repository =
            CountriesRepositoryImp(localDataSource, remoteDataSource);
        mo.when(remoteDataSource.getCountries()).thenThrow(ServerException());

        // act
        final res = await repository.getAvailableCountries();

        // assert

        mo.verify(remoteDataSource.getCountries());
        mo.verifyNever(localDataSource.cacheCountries(mo.any));
        expect(res, Left(ServerFailure()));
      });
    });
  });
}
