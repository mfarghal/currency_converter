import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/init/network/network_constants.dart';
import '../models/exhange_rate_model.dart';

abstract class ExhangeRemoteDataSource {
  /// Get the [ExhangeRateModel] from api call
  ///
  /// Throw [ServerException] for all error state codes.
  Future<ExhangeRateModel> getConversionRate(
      {required String from, required String to});
}

class ExhangeRemoteDataSourceImpl implements ExhangeRemoteDataSource {
  final http.Client client;
  ExhangeRemoteDataSourceImpl(this.client);

  @override
  Future<ExhangeRateModel> getConversionRate(
      {required String from, required String to}) async {
    // /api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&apiKey=[YOUR_API_KEY]

    final res = await client.get(
      Uri.parse(
          '${NetworkConstants.baseURL}/api/v7/convert?q=${from}_$to&compact=ultra&apiKey=${ApplicationConstants.API_KEY}'),
      headers: NetworkConstants.headers,
    );
    if (res.statusCode != 200) throw ServerException();

    return ExhangeRateModel.fromJson(json.decode(res.body));
  }
}
