import 'dart:convert';

import 'package:currency_converter_demo/core/constants/app/app_constants.dart';
import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:currency_converter_demo/core/init/network/network_constants.dart';

import '../../models/country_model.dart';
import 'package:http/http.dart' as http;

abstract class CountriesRemoteDataSource {
  /// Get the [CountryModel] from api call
  ///
  /// Throw [ServerException] for all error state codes.
  Future<List<CountryModel>> getCountries();
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {
  final http.Client client;

  CountriesRemoteDataSourceImpl(this.client);

  @override
  Future<List<CountryModel>> getCountries() async {
    final res = await client.get(
      Uri.parse(
          '${NetworkConstants.baseURL}/api/v7/countries?apiKey=${ApplicationConstants.API_KEY}'),
      headers: NetworkConstants.headers,
    );
    if (res.statusCode != 200) throw ServerException();

    Map jsons = json.decode(res.body)['results'];
    return List<CountryModel>.from(
        jsons.values.map((model) => CountryModel.fromJson(model)));
  }
}
