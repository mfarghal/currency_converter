import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String alpha3;
  final String currencyId;
  final String currencyName;
  final String currencySymbol;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.alpha3,
    required this.currencyId,
    required this.currencyName,
    required this.currencySymbol,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        alpha3,
        currencyId,
        currencyName,
        currencySymbol,
      ];
}
