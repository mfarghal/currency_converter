import 'dart:convert';
import 'dart:io';

import 'package:currency_converter_demo/core/constants/app/app_constants.dart';
import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/network/network_constants.dart';
import 'package:currency_converter_demo/features/countries/data/datasources/countries_remote_data_source.dart';
import 'package:currency_converter_demo/features/countries/data/models/country_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart' as mo;
import '../../../../fixtures/fixture_reader.dart';
import 'countries_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('currencies remote data soruce', () {
    group('should return model', () {
      test('should perform GET request on URL with application/json header',
          () async {
        // arrange
        final mock = MockClient();
        final dataSource = CountriesRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
              (realInvocation) async => Future.value(
                http.Response(
                  fixture('countries.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },
                ),
              ),
            );

        // act
        dataSource.getCountries();

        // assert
        mo.verify(
          mock.get(
            Uri.parse(
                '${NetworkConstants.baseURL}/api/v7/countries?apiKey=${ApplicationConstants.API_KEY}'),
            headers: NetworkConstants.headers,
          ),
        );
      });

      test('should return list of currencies when responce code 200', () async {
        // arrange
        Map jsons = json.decode(fixture('countries.json'))['results'];
        final currencies = List<CountryModel>.from(
            jsons.values.map((model) => CountryModel.fromJson(model)));
        // Iterable l = ;
        //  = List<CountryModel>.from(
        //     l.map((model) => CountryModel.fromJson(model)));

        final mock = MockClient();
        final dataSource = CountriesRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
              (realInvocation) async => Future.value(
                http.Response(
                  fixture('countries.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },
                ),
              ),
            );

        // act
        final result = await dataSource.getCountries();

        // assert
        expect(result, currencies);
      });
    });

    group('should throw exception', () {
      test('should throw server exception when responce code not equal 200',
          () async {
        // arrange
        final mock = MockClient();
        final dataSource = CountriesRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
            (realInvocation) async => Future.value(http.Response('', 404)));
        // act
        final call = dataSource.getCountries;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
      });
    });
  });
}
