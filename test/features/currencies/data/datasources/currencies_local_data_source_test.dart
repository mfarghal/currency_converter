import 'dart:convert';

import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/features/currencies/data/datasources/currencies_local_data_source.dart';
import 'package:currency_converter_demo/features/currencies/data/models/currency_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart' as mo;
import '../../../../fixtures/fixture_reader.dart';
import 'currencies_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  group('currencies local data soruce', () {
    group('add', () {
      test('should save on local storage', () async {
        // arrange
        Iterable l = json.decode(fixture('currencies.json'));
        final currencies = List<CurrencyModel>.from(
            l.map((model) => CurrencyModel.fromJson(model)));

        final mock = MockSharedPreferences();
        final dataSource = CurrenciesLocalDataSourceImpl(mock);

        // act
        dataSource.cacheCurrencies(currencies);

        // assert
        final string = json
            .encode(currencies.map((currency) => currency.toJson()).toList());

        mo.verify(mock.setString(CACHED_CURRENCIES, string));
      });
    });
    group('fetch', () {
      group('should return model', () {
        test('should return from local storage when there is data', () async {
          // arrange
          Iterable l = json.decode(fixture('currencies.json'));
          final currencies = List<CurrencyModel>.from(
              l.map((model) => CurrencyModel.fromJson(model)));

          final mock = MockSharedPreferences();
          final dataSource = CurrenciesLocalDataSourceImpl(mock);
          mo
              .when(mock.getString(mo.any))
              .thenReturn(fixture('currencies.json'));

          // act
          final res = await dataSource.getCachedCurrencies();

          // assert
          mo.verify(mock.getString(CACHED_CURRENCIES));
          expect(res, currencies);
        });
      });
      group('should throw exception', () {
        test('shoudl throw cache excption when local storage is empty',
            () async {
          // arrange
          final mock = MockSharedPreferences();
          final dataSource = CurrenciesLocalDataSourceImpl(mock);
          mo.when(mock.getString(mo.any)).thenReturn('');

          // act
          final call = dataSource.getCachedCurrencies;

          // assert
          expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
        });
      });
    });
  });
}
