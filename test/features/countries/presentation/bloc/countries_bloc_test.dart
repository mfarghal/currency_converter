import 'package:currency_converter_demo/core/error/failure.dart';
import 'package:currency_converter_demo/core/usecases/usecase.dart';
import 'package:currency_converter_demo/features/countries/domain/usecases/get_available_countries.dart';
import 'package:currency_converter_demo/features/countries/presentation/bloc/bloc/countries_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mo;

import 'countries_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetAvailableCountries>(),
])
void main() {
  group('GetAvailableCountries', () {
    test('initialState should be empty', () async {
      // arrange
      final CountriesBloc bloc;

      final MockGetAvailableCountries mockGetAvailableCountries;
      mockGetAvailableCountries = MockGetAvailableCountries();

      bloc = CountriesBloc(
        getAvailableCountriesUseCase: mockGetAvailableCountries,
      );
      // act

      // assert
      expect(bloc.state, CountriesInitial());
    });

    test('should emit error when the input is invalid', () async {
      // arrange
      final CountriesBloc bloc;
      final MockGetAvailableCountries mockGetAvailableCountries;
      mockGetAvailableCountries = MockGetAvailableCountries();

      bloc = CountriesBloc(
        getAvailableCountriesUseCase: mockGetAvailableCountries,
      );

      mo
          .when(mockGetAvailableCountries(mo.any))
          .thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));

      // assert
      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            CountriesLoading(),
            CountriesError(),
          ],
        ),
      );

      // act
      bloc.add(RequestAllAvaliableCountriesEvent());
    });
    test('should get data from the use case', () async {
      // arrange
      final CountriesBloc bloc;
      final MockGetAvailableCountries mockGetAvailableCountries;
      mockGetAvailableCountries = MockGetAvailableCountries();

      bloc = CountriesBloc(
        getAvailableCountriesUseCase: mockGetAvailableCountries,
      );

      mo
          .when(mockGetAvailableCountries(mo.any))
          .thenAnswer((realInvocation) async => const Right([]));
      // act
      bloc.add(RequestAllAvaliableCountriesEvent());
      await mo.untilCalled(mockGetAvailableCountries(mo.any));
      // assert
      mo.verify(mockGetAvailableCountries(NoParams()));
    });
  });
}
