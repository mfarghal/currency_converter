import 'package:currency_converter_demo/features/currencies/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class CurrenciesRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getAvailableCurrencies();
}
