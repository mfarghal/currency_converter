import 'dart:convert';

import 'package:currency_converter_demo/core/usecases/usecase.dart';
import 'package:currency_converter_demo/features/countries/data/models/country_model.dart';

import 'package:currency_converter_demo/features/countries/domain/usecases/get_available_countries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mo;
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('get_available_currencies usecase', () {
    test('should get list of currencies when call get functions successfully',
        () async {
      // arrange
      final l = [
        CountryModel.fromJson(json.decode(fixture('country.json'))),
      ];

      // final mock = MockCurrenciesRepository();
      // final getAvailableCurrencies = GetAvailableCountries(mock);
      // mo
      //     .when(mock.getAvailableCurrencies())
      //     .thenAnswer((realInvocation) async => Future.value(Right(l)));
      // // act
      // final res = await getAvailableCurrencies(NoParams());

      // // assert
      // expect(res, Right(l));
      // mo.verify(mock.getAvailableCurrencies());
      // mo.verifyNoMoreInteractions(mock);
    });
  });
}
