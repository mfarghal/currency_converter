import 'package:currency_converter_demo/core/error/exception.dart';

import '../../../../../../core/proto/hive_data_source.dart';
import 'countries.dart';
import '../../../models/country_model.dart';

import 'package:hive/hive.dart';

class CountriesHiveDataSource implements HiveDataSource<CountryModel> {
  final _kCountriesBox = 'countries_box';

  @override
  Future<bool> init() async {
    try {
      Hive.registerAdapter(CountriesAdapter());
      await Hive.openBox<Countries>(_kCountriesBox);

      //
      return true;
    } catch (_) {
      throw '';
    }
  }

  @override
  Future<void> add(CountryModel obj) async {
    try {
      final countriesBox = Hive.box<Countries>(_kCountriesBox);

      final convertedCountry = Countries(
        id: obj.id,
        name: obj.name,
        currencyId: obj.currencyId,
        currencyName: obj.currencyName,
        currencySymbol: obj.currencySymbol,
        alpha3: obj.alpha3,
      );
      await countriesBox.add(convertedCountry);
      return;
    } catch (_) {
      throw '';
    }
  }

  @override
  Future<void> delete(CountryModel obj) async {
    final countiesBox = Hive.box<Countries>(_kCountriesBox);
    await countiesBox.delete(obj.id);
    return;
  }

  @override
  Future<void> deleteAll() async {
    final countiesBox = Hive.box<Countries>(_kCountriesBox);
    await countiesBox.clear();
    return;
  }

  @override
  Future<List<CountryModel>> getAll() {
    try {
      final countiesBox = Hive.box<Countries>(_kCountriesBox);
      final result = countiesBox.values
          .map<CountryModel>(
            (e) => CountryModel(
              id: e.id,
              name: e.name,
              currencyId: e.currencyId,
              currencyName: e.currencyName,
              currencySymbol: e.currencySymbol,
              alpha3: e.alpha3,
            ),
          )
          .toList();
      return Future.value(result);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  int count() {
    final countiesBox = Hive.box<Countries>(_kCountriesBox);
    return countiesBox.length;
  }
}
