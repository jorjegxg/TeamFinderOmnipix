import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';

class Alocation {
  final String id;
  final String comments;
  int workHours;
  List<TeamRole> teamRoles;
  final String employeeName;

  Alocation({
    required this.id,
    required this.comments,
    required this.workHours,
    required this.teamRoles,
    required this.employeeName,
  });

  //to/from map
  factory Alocation.fromMap(Map<String, dynamic> map) {
    return Alocation(
      employeeName: map['employeeName'],
      id: map['id'],
      comments: map['comment'],
      workHours: map['numberOfHours'],
      teamRoles: (map['teamRolesId'] as List)
          .map((e) => TeamRole.fromJson(e))
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'comments': comments,
      'workHours': workHours,
      'teamRoles': teamRoles.map((e) => e.toJson()).toList(),
      'employeeName': employeeName,
    };
  }

  //get string from list
  String getTeamRolesString() {
    String result = '';
    for (var i = 0; i < teamRoles.length; i++) {
      result += teamRoles[i].name;
      if (i != teamRoles.length - 1) {
        result += ', ';
      }
    }
    return result;
  }
}
