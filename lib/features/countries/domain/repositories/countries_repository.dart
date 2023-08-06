import 'package:currency_converter_demo/features/countries/domain/entities/country_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class CountriesRepository {
  Future<Either<Failure, List<CountryEntity>>> getAvailableCountries();
}
