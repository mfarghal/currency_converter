import 'package:hive/hive.dart';

part 'countries.g.dart';

@HiveType(typeId: 1)
class Countries {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String alpha3;
  @HiveField(3)
  final String currencyId;
  @HiveField(4)
  final String currencyName;
  @HiveField(5)
  final String currencySymbol;

  Countries(
      {required this.id,
      required this.name,
      required this.alpha3,
      required this.currencyId,
      required this.currencyName,
      required this.currencySymbol});
}
