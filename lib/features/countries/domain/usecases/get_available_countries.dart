import 'package:currency_converter_demo/features/countries/domain/repositories/countries_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/country_entity.dart';

class GetAvailableCountries extends UseCase<List<CountryEntity>, NoParams> {
  final CountriesRepository repository;

  GetAvailableCountries(this.repository);

  @override
  Future<Either<Failure, List<CountryEntity>>> call(
    NoParams params,
  ) =>
      repository.getAvailableCountries();
}
