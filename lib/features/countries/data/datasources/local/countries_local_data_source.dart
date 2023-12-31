import '../../../../../core/error/exception.dart';
import 'hive/countries_hive_data_source.dart';

import '../../models/country_model.dart';

abstract class CountriesLocalDataSource {
  Future<bool> get isEmptyLocalStorage;

  /// Get the cached [CountryModel]
  ///
  /// Throw [CacheException] if no cached data is present.
  Future<List<CountryModel>> getCachedCountries();

  Future<bool> cacheCountries(List<CountryModel> model);
}

class CountriesLocalDataSourceImpl implements CountriesLocalDataSource {
  final CountriesHiveDataSource ds;

  CountriesLocalDataSourceImpl(this.ds);
  @override
  Future<bool> get isEmptyLocalStorage => Future.value(ds.count() == 0);

  @override
  Future<bool> cacheCountries(List<CountryModel> models) async {
    await Future.wait([for (var model in models) ds.add(model)]);
    return true;
  }

  @override
  Future<List<CountryModel>> getCachedCountries() => ds.getAll();
}
/*
// ignore: constant_identifier_names
const CACHED_COUNTRIES = 'CACHED_COUNTRIES';

class CountriesLocalDataSourceImpl implements CountriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  CountriesLocalDataSourceImpl(this.sharedPreferences);

  //
  @override
  Future<bool> get isEmptyLocalStorage => Future.value(
      (sharedPreferences.getString(CACHED_COUNTRIES) ?? '').isEmpty);

  @override
  Future<bool> cacheCountries(List<CountryModel> currencies) async {
    final string =
        json.encode(currencies.map((currency) => currency.toJson()).toList());

    return sharedPreferences.setString(CACHED_COUNTRIES, string);
  }

  @override
  Future<List<CountryModel>> getCachedCountries() {
    final jsonString = sharedPreferences.getString(CACHED_COUNTRIES) ?? '';

    if (jsonString.isEmpty) throw CacheException();

    Iterable l = json.decode(jsonString);
    final currencies =
        List<CountryModel>.from(l.map((model) => CountryModel.fromJson(model)));
    return Future.value(currencies);
  }
}*/
