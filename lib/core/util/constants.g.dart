// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constants.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectPeriodAdapter extends TypeAdapter<ProjectPeriod> {
  @override
  final int typeId = 4;

  @override
  ProjectPeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ProjectPeriod.fixed;
      case 1:
        return ProjectPeriod.ongoing;
      default:
        return ProjectPeriod.fixed;
    }
  }

  @override
  void write(BinaryWriter writer, ProjectPeriod obj) {
    switch (obj) {
      case ProjectPeriod.fixed:
        writer.writeByte(0);
        break;
      case ProjectPeriod.ongoing:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
