import 'package:currency_converter_demo/features/exhange/domain/entities/exhange_rate_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class ExhangeRepository {
  Future<Either<Failure, ExhangeRateEntity>> getConvertRate(
      String fromCurrencyId, String toCurrencyId);
}
