import 'dart:convert';

import 'package:currency_converter_demo/core/constants/app/app_constants.dart';
import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/network/network_constants.dart';
import 'package:currency_converter_demo/features/currencies/data/datasources/currencies_remote_data_source.dart';
import 'package:currency_converter_demo/features/currencies/data/models/currency_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart' as mo;
import '../../../../fixtures/fixture_reader.dart';
import 'currencies_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('currencies remote data soruce', () {
    group('should return model', () {
      test('should perform GET request on URL with application/json header',
          () async {
        // arrange
        final mock = MockClient();
        final dataSource = CurrenciesRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
            (realInvocation) async =>
                Future.value(http.Response(fixture('currencies.json'), 200)));

        // act
        dataSource.getCurrencies();

        // assert
        mo.verify(
          mock.get(
            Uri.parse(
                '${NetworkConstants.baseURL}/api/v7/currencies?apiKey=${ApplicationConstants.API_KEY}'),
            headers: NetworkConstants.headers,
          ),
        );
      });

      test('should return list of currencies when responce code 200', () async {
        // arrange
        Iterable l = json.decode(fixture('currencies.json'));
        final currencies = List<CurrencyModel>.from(
            l.map((model) => CurrencyModel.fromJson(model)));

        final mock = MockClient();
        final dataSource = CurrenciesRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
            (realInvocation) async =>
                Future.value(http.Response(fixture('currencies.json'), 200)));

        // act
        final result = await dataSource.getCurrencies();

        // assert
        expect(result, currencies);
      });
    });

    group('should throw exception', () {
      test('should throw server exception when responce code not equal 200',
          () async {
        // arrange
        final mock = MockClient();
        final dataSource = CurrenciesRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
            (realInvocation) async => Future.value(http.Response('', 404)));
        // act
        final call = dataSource.getCurrencies;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      });
    });
  });
}
