import 'package:hive/hive.dart';

part 'fuel_record.g.dart';

@HiveType(typeId: 1)
class FuelRecord {
  @HiveField(0)
  DateTime dateAdded;

  @HiveField(1)
  double litresOfFuel;

  @HiveField(2)
  double milesTravelled;

  FuelRecord(
      {required this.litresOfFuel,
      required this.milesTravelled,
      required this.dateAdded});
}
