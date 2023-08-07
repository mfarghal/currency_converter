import 'dart:convert';

import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/features/countries/data/datasources/local/countries_local_data_source.dart';
import 'package:currency_converter_demo/features/countries/data/datasources/local/hive/countries_hive_data_source.dart';
import 'package:currency_converter_demo/features/countries/data/models/country_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart' as mo;
import '../../../../fixtures/fixture_reader.dart';
import 'countries_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CountriesHiveDataSource>()])
void main() {
  group('currencies local data soruce', () {
    group('add', () {
      test('should save on local storage', () async {
        // arrange
        Map jsons = json.decode(fixture('countries.json'))['results'];
        final currencies = List<CountryModel>.from(
            jsons.values.map((model) => CountryModel.fromJson(model)));

        final mock = MockCountriesHiveDataSource();
        final dataSource = CountriesLocalDataSourceImpl(mock);

        // act
        dataSource.cacheCountries(currencies);

        // assert
        mo.verify(mock.add(mo.any)).called(currencies.length);
      });
    });
    group('fetch', () {
      group('should return model', () {
        test('should return from local storage when there is data', () async {
          // arrange
          Map jsons = json.decode(fixture('countries.json'))['results'];
          final currencies = List<CountryModel>.from(
              jsons.values.map((model) => CountryModel.fromJson(model)));

          final mock = MockCountriesHiveDataSource();
          final dataSource = CountriesLocalDataSourceImpl(mock);

          mo
              .when(mock.getAll())
              .thenAnswer((realInvocation) => Future.value(currencies));

          // act
          final res = await dataSource.getCachedCountries();

          // assert
          mo.verify(mock.getAll());
          expect(res, currencies);
        });
      });
      group('should throw exception', () {
        test('shoudl throw cache excption when local storage is empty',
            () async {
          // arrange
          final mock = MockCountriesHiveDataSource();
          final dataSource = CountriesLocalDataSourceImpl(mock);
          mo.when(mock.getAll()).thenThrow(CacheException());

          // act
          final call = dataSource.getCachedCountries;

          // assert
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        });
      });
    });
  });
}
