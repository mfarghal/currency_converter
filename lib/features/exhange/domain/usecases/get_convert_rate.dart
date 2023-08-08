import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/exhange_rate_entity.dart';
import '../repositories/exhange_repository.dart';

class GetConvertRate extends UseCase<ExhangeRateEntity, Params> {
  final ExhangeRepository repository;

  GetConvertRate(this.repository);

  @override
  Future<Either<Failure, ExhangeRateEntity>> call(
    Params params,
  ) =>
      repository.getConvertRate(params.fromCurrencyId, params.toCurrencyId);
}

class Params extends Equatable {
  final String toCurrencyId;
  final String fromCurrencyId;

  const Params({required this.toCurrencyId, required this.fromCurrencyId});
  @override
  List<Object?> get props => [toCurrencyId, fromCurrencyId];
}
