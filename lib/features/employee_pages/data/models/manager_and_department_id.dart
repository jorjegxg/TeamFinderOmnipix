import 'package:team_finder_app/features/auth/data/models/manager.dart';

class ManagerAndDepartmentId {
  final Manager? newManager;
  final String? departmentId;

  ManagerAndDepartmentId(
      {required this.newManager, required this.departmentId});
}
