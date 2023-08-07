// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountriesAdapter extends TypeAdapter<Countries> {
  @override
  final int typeId = 1;

  @override
  Countries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Countries(
      id: fields[0] as String,
      name: fields[1] as String,
      alpha3: fields[2] as String,
      currencyId: fields[3] as String,
      currencyName: fields[4] as String,
      currencySymbol: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Countries obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.alpha3)
      ..writeByte(3)
      ..write(obj.currencyId)
      ..writeByte(4)
      ..write(obj.currencyName)
      ..writeByte(5)
      ..write(obj.currencySymbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
