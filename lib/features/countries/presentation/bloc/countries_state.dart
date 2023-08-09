part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<CountryEntity> list;

  const CountriesLoaded(this.list);
}

class CountriesError extends CountriesState {}
