import 'dart:convert';

import 'package:currency_converter_demo/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/currency_model.dart';

abstract class CurrenciesLocalDataSource {
  Future<bool> get isEmptyLocalStorage;

  /// Get the cached [CurrencyModel]
  ///
  /// Throw [CacheException] if no cached data is present.
  Future<List<CurrencyModel>> getCachedCurrencies();

  Future<bool> cacheCurrencies(List<CurrencyModel> model);
}

// ignore: constant_identifier_names
const CACHED_CURRENCIES = 'CACHED_CURRENCIES';

class CurrenciesLocalDataSourceImpl implements CurrenciesLocalDataSource {
  final SharedPreferences sharedPreferences;

  CurrenciesLocalDataSourceImpl(this.sharedPreferences);

  //
  @override
  Future<bool> get isEmptyLocalStorage => throw UnimplementedError();

  @override
  Future<bool> cacheCurrencies(List<CurrencyModel> currencies) async {
    final string =
        json.encode(currencies.map((currency) => currency.toJson()).toList());

    return sharedPreferences.setString(CACHED_CURRENCIES, string);
  }

  @override
  Future<List<CurrencyModel>> getCachedCurrencies() {
    final jsonString = sharedPreferences.getString(CACHED_CURRENCIES) ?? '';

    if (jsonString.isEmpty) throw CacheException();

    Iterable l = json.decode(jsonString);
    final currencies = List<CurrencyModel>.from(
        l.map((model) => CurrencyModel.fromJson(model)));
    return Future.value(currencies);
  }
}
