import 'package:currency_converter_demo/features/countries/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.id,
    required super.name,
    required super.alpha3,
    required super.currencyId,
    required super.currencyName,
    required super.currencySymbol,
  });

  factory CountryModel.fromJson(Map<String, dynamic> jsonMap) => CountryModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        currencyId: jsonMap['currencyId'],
        currencyName: jsonMap['currencyName'],
        currencySymbol: jsonMap['currencySymbol'],
        alpha3: jsonMap['alpha3'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'currencyId': currencyId,
        'currencyName': currencyName,
        'currencySymbol': currencySymbol,
        'alpha3': alpha3,
      };
}
