import 'dart:convert';

import 'package:currency_converter_demo/core/constants/app/app_constants.dart';
import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/network/network_constants.dart';

import '../models/currency_model.dart';
import 'package:http/http.dart' as http;

abstract class CurrenciesRemoteDataSource {
  /// Get the [CurrencyModel] from api call
  ///
  /// Throw [ServerException] for all error state codes.
  Future<List<CurrencyModel>> getCurrencies();
}

class CurrenciesRemoteDataSourceImpl implements CurrenciesRemoteDataSource {
  final http.Client client;

  CurrenciesRemoteDataSourceImpl(this.client);

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    final res = await client.get(
      Uri.parse(
          '${NetworkConstants.baseURL}/api/v7/currencies?apiKey=${ApplicationConstants.API_KEY}'),
      headers: NetworkConstants.headers,
    );
    if (res.statusCode != 200) throw ServerException();

    Iterable l = json.decode(res.body);
    return List<CurrencyModel>.from(
        l.map((model) => CurrencyModel.fromJson(model)));
  }
}
