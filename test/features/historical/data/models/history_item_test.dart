import 'dart:convert';

import 'package:currency_converter_demo/features/historical/data/models/history_item_model.dart';
import 'package:currency_converter_demo/features/historical/domain/entities/history_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('history item model', () {
    test('should be subclass of History Item Entity', () async {
      // arrange
      const model = HistoryItemModel(1);

      // act

      // assert
      expect(model, isA<HistoryItemEntity>());
    });
  });
  group('fromJson', () {
    test('should return a vaild model when !! ', () async {
      // arrange
      const model = HistoryItemModel(1);
      final jsonMap = json.decode(fixture('history.json'));

      // act
      final res = HistoryItemModel.fromJson(jsonMap);

      // assert
      expect(res, model);
    });
  });
  group('toJson', () {
    test('should return JSON map containing the proper data', () async {
      // arrange
      const model = HistoryItemModel(1);

      final expectedJson = json.decode(fixture('history.json'));

      // act
      final res = model.toJson();
      // assert
      expect(res, expectedJson);
    });
  });
}
