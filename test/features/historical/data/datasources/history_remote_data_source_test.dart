import 'dart:io';

import 'package:currency_converter_demo/core/constants/app/app_constants.dart';
import 'package:currency_converter_demo/core/init/network/network_constants.dart';
import 'package:currency_converter_demo/features/historical/data/datasources/history_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart' as mo;

import '../../../../fixtures/fixture_reader.dart';
import 'history_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('history remote data soruce', () {
    group('should return model', () {
      test('should perform GET request on URL with application/json header',
          () async {
        // arrange
        const from = '2023-08-02';
        const to = '2023-08-09';
        const q = ['BRL_AUD', 'AUD_BRL'];
        //
        final mock = MockClient();
        final dataSource = HistoryRemoteDataSourceImpl(mock);
        mo.when(mock.get(mo.any, headers: mo.anyNamed('headers'))).thenAnswer(
              (realInvocation) async => Future.value(
                http.Response(
                  fixture('history.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  },
                ),
              ),
            );

        // act
        dataSource.getHistoryForDateRange(from, to, q);

        // assert
        mo.verify(
          mock.get(
            Uri.parse(
                '${NetworkConstants.baseURL}/api/v7/convert?q=${q.join(',')}&compact=ultra&date=$from&endDate=$to&apiKey=${ApplicationConstants.API_KEY}'),
            headers: NetworkConstants.headers,
          ),
        );
      });
    });
  });
}
