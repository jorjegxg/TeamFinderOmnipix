// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectEntityAdapter extends TypeAdapter<ProjectEntity> {
  @override
  final int typeId = 0;

  @override
  ProjectEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      teamRoles: (fields[2] as Map).cast<TeamRole, int>(),
      technologyStack: (fields[3] as List).cast<TechnologyStack>(),
      projectManager: fields[4] as String,
      period: fields[5] as ProjectPeriod,
      startDate: fields[6] as DateTime,
      deadlineDate: fields[7] as DateTime,
      description: fields[8] as String,
      status: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.teamRoles)
      ..writeByte(3)
      ..write(obj.technologyStack)
      ..writeByte(4)
      ..write(obj.projectManager)
      ..writeByte(5)
      ..write(obj.period)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.deadlineDate)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
