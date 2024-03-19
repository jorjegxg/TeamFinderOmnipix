import 'package:equatable/equatable.dart';

class TeamRole extends Equatable {
  final String name;
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
