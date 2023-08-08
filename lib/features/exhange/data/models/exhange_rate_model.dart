import '../../domain/entities/exhange_rate_entity.dart';

class ExhangeRateModel extends ExhangeRateEntity {
  const ExhangeRateModel({required super.rate});

  factory ExhangeRateModel.fromJson(Map<String, dynamic> jsonMap) =>
      ExhangeRateModel(
        rate: jsonMap.values.first,
      );
}
