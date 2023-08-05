import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/currency_entity.dart';
import '../repositories/currencies_repository.dart';

class GetAvailableCurrencies extends UseCase<List<CurrencyEntity>, NoParams> {
  final CurrenciesRepository repository;

  GetAvailableCurrencies(this.repository);

  @override
  Future<Either<Failure, List<CurrencyEntity>>> call(
    NoParams params,
  ) =>
      repository.getAvailableCurrencies();
}
