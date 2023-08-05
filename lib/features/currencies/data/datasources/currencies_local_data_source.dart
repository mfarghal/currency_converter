import '../models/currency_model.dart';

abstract class CurrenciesLocalDataSource {
  Future<bool> get isEmptyLocalStorage;

  /// Get the cached [CurrencyModel]
  ///
  /// Throw [CacheException] if no cached data is present.
  Future<List<CurrencyModel>> getCachedCurrencies();

  Future<void> cacheCurrencies(List<CurrencyModel> model);
}
