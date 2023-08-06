import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/error/failure.dart';
import 'package:currency_converter_demo/features/historical/data/datasources/history_remote_data_source.dart';
import 'package:currency_converter_demo/features/historical/data/models/history_item_model.dart';
import 'package:currency_converter_demo/features/historical/data/repositories/history_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mo;

import 'history_repository_imp_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HistoryRemoteDataSource>()])
void main() {
  group('history_repository_imp', () {
    final q = ['USD_PHP', 'PHP_USD'];
    test('should return remote data when call to remote data source is success',
        () async {
      final l = [const HistoryItemModel(1), const HistoryItemModel(2)];
      final remoteDataSource = MockHistoryRemoteDataSource();
      final repository = HistoryRepositoryImpl(remoteDataSource);
      mo
          .when(remoteDataSource.getHistoryForLast7Days(mo.any))
          .thenAnswer((realInvocation) => Future.value(l));

      // act
      final res = await repository.getLast7Days(q);

      // assert
      mo.verify(
          remoteDataSource.getHistoryForLast7Days(['USD_PHP', 'PHP_USD']));
      expect(res, Right(l));
    });

    test(
        'should return server failure when the call to remote data source unsuccessful',
        () async {
      // arrange
      final remoteDataSource = MockHistoryRemoteDataSource();
      final repository = HistoryRepositoryImpl(remoteDataSource);

      mo
          .when(remoteDataSource.getHistoryForLast7Days(mo.any))
          .thenThrow(ServerException());

      // act
      final res = await repository.getLast7Days(q);

      // assert

      mo.verify(remoteDataSource.getHistoryForLast7Days(q));
      expect(res, Left(ServerFailure()));
    });
  });
}
