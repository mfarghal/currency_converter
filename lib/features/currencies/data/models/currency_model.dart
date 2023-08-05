import 'package:currency_converter_demo/features/currencies/domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel(super.id);

  factory CurrencyModel.fromJson(Map<String, dynamic> jsonMap) => CurrencyModel(
        jsonMap['id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
