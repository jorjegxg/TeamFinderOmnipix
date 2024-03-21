import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'team_role.g.dart';

@HiveType(typeId: 1)
class TeamRole extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;

  const TeamRole({required this.name, required this.id});

  //from json and to json methods
  factory TeamRole.fromJson(Map<String, dynamic> json) {
    return TeamRole(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [name, id];
}
