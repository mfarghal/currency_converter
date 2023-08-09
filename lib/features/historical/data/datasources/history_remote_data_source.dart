import 'dart:convert';
import 'dart:developer';

import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/init/network/network_constants.dart';
import '../models/history_item_model.dart';

import 'package:http/http.dart' as http;

abstract class HistoryRemoteDataSource {
  Future<List<HistoryItemModel>> getHistoryForDateRange(
      String from, String to, List<String> q);
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final http.Client client;

  HistoryRemoteDataSourceImpl(this.client);

  ///
  @override
  Future<List<HistoryItemModel>> getHistoryForDateRange(
      String from, String to, List<String> q) async {
    // /api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&date=[yyyy-mm-dd]&endDate=[yyyy-mm-dd]&apiKey=[YOUR_API_KEY]

    final res = await client.get(
      Uri.parse(
          '${NetworkConstants.baseURL}/api/v7/convert?q=${q.join(',')}&compact=ultra&date=$from&endDate=$to&apiKey=${ApplicationConstants.API_KEY}'),
      headers: NetworkConstants.headers,
    );
    if (res.statusCode != 200) throw ServerException();

    final j = json.decode(res.body);
    final jsons = j.keys.map(
      (e) => {
        'from': e.split('_').first,
        'to': e.split('_').last,
        'conversions_rate': (j[e] as Map<String, dynamic>)
            .keys
            .map((i) => {'date': i, 'val': j[e][i]})
            .toList()
      },
    );

    return List<HistoryItemModel>.from(
        jsons.map((model) => HistoryItemModel.fromJson(model)));
  }
}
