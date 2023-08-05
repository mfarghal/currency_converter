import 'dart:convert';

import 'package:currency_converter_demo/features/currencies/data/models/currency_model.dart';
import 'package:currency_converter_demo/features/currencies/domain/entities/currency_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('', () {
    test('should be subclass of Currency Entity', () async {
      // arrange
      const currencyModel = CurrencyModel(1);

      // act

      // assert
      expect(currencyModel, isA<CurrencyEntity>());
    });
  });
  group('fromJson', () {
    test('should return a vaild model when !! ', () async {
      // arrange
      const currencyModel = CurrencyModel(1);
      final jsonMap = json.decode(fixture('currency.json'));

      // act
      final res = CurrencyModel.fromJson(jsonMap);

      // assert
      expect(res, currencyModel);
    });
  });
  group('toJson', () {
    test('should return JSON map containing the proper data', () async {
      // arrange
      const currencyModel = CurrencyModel(1);

      final expectedJson = json.decode(fixture('currency.json'));

      // act
      final res = currencyModel.toJson();
      // assert
      expect(res, expectedJson);
    });
  });
}
