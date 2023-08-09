// import 'package:currency_converter_demo/features/historical/domain/entities/history_item_entity.dart';
// import 'package:currency_converter_demo/features/historical/domain/usecases/get_history_for_7_days.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart' as mo;

// import 'mocks/mocks.mocks.dart';

// void main() {
//   group('get_history_for_7_days usecase', () {
//     test('should get list of history when call get functions successfully',
//         () async {
//       // arrange
//       final q = ['USD_PHP', 'PHP_USD'];
//       final l = [
//         const HistoryItemEntity(1),
//         const HistoryItemEntity(2),
//       ];
//       final mock = MockHistoryRepository();
//       final getHistoryFor7Days = GetHistoryFor7Days(mock);
//       mo
//           .when(mock.getLast7Days(mo.any))
//           .thenAnswer((realInvocation) async => Future.value(Right(l)));

//       // act
//       final res = await getHistoryFor7Days(Params(q));

//       // assert
//       expect(res, Right(l));
//       mo.verify(mock.getLast7Days(q));
//       mo.verifyNoMoreInteractions(mock);
//     });
//   });
// }
