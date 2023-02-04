// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberModelAdapter extends TypeAdapter<MemberModel> {
  @override
  final int typeId = 1;

  @override
  MemberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberModel(
      memberName: fields[3] as String?,
      email: fields[4] as String?,
      dob: fields[5] as String?,
      designation: fields[6] as String?,
      gender: fields[7] as String?,
      skill: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MemberModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(3)
      ..write(obj.memberName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.designation)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.skill);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
