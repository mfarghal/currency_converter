import 'package:currency_converter_demo/core/usecases/usecase.dart';
import 'package:currency_converter_demo/features/currencies/domain/entities/currency_entity.dart';
import 'package:currency_converter_demo/features/currencies/domain/usecases/get_available_currencies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mo;
import 'mocks/mocks.mocks.dart';

void main() {
  group('get_available_currencies usecase', () {
    test('should get list of currencies when call get functions successfully',
        () async {
      // arrange
      final l = [const CurrencyEntity(1)];

      final mock = MockCurrenciesRepository();
      final getAvailableCurrencies = GetAvailableCurrencies(mock);
      mo
          .when(mock.getAvailableCurrencies())
          .thenAnswer((realInvocation) async => Future.value(Right(l)));
      // act
      final res = await getAvailableCurrencies(NoParams());

      // assert
      expect(res, Right(l));
      mo.verify(mock.getAvailableCurrencies());
      mo.verifyNoMoreInteractions(mock);
    });
  });
}
