// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelRecordAdapter extends TypeAdapter<FuelRecord> {
  @override
  final int typeId = 1;

  @override
  FuelRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelRecord(
      litresOfFuel: fields[1] as double,
      milesTravelled: fields[2] as double,
      dateAdded: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FuelRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateAdded)
      ..writeByte(1)
      ..write(obj.litresOfFuel)
      ..writeByte(2)
      ..write(obj.milesTravelled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
