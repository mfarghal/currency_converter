import 'dart:convert';

import 'package:currency_converter_demo/features/countries/data/models/country_model.dart';
import 'package:currency_converter_demo/features/countries/domain/entities/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('', () {
    test('should be subclass of Currency Entity', () async {
      // arrange
      const currencyModel = CountryModel(
        id: "WF",
        name: "Wallis and Futuna Islands",
        alpha3: "WLF",
        currencyId: "XPF",
        currencyName: "CFP franc",
        currencySymbol: "Fr",
      );

      // act

      // assert
      expect(currencyModel, isA<CountryEntity>());
    });
  });
  group('fromJson', () {
    test('should return a vaild model when !! ', () async {
      // arrange
      const currencyModel = CountryModel(
        id: "WF",
        name: "Wallis and Futuna Islands",
        alpha3: "WLF",
        currencyId: "XPF",
        currencyName: "CFP franc",
        currencySymbol: "Fr",
      );
      final jsonMap = json.decode(fixture('country.json'));

      // act
      final res = CountryModel.fromJson(jsonMap);

      // assert
      expect(res, currencyModel);
    });
  });
  group('toJson', () {
    test('should return JSON map containing the proper data', () async {
      // arrange
      const currencyModel = CountryModel(
        id: "WF",
        name: "Wallis and Futuna Islands",
        alpha3: "WLF",
        currencyId: "XPF",
        currencyName: "CFP franc",
        currencySymbol: "Fr",
      );

      final expectedJson = json.decode(fixture('country.json'));

      // act
      final res = currencyModel.toJson();
      // assert
      expect(res, expectedJson);
    });
  });
}
