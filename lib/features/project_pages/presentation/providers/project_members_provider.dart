import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee_teamrole.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class ProjectMembersProvider extends ChangeNotifier {
  List<EmployeeTeamRole> activeMembers = [];
  List<EmployeeTeamRole> pastMembers = [];
  List<EmployeeTeamRole> futureMembers = [];
  final ProjectsUsecase _projectsUsecase;
  bool _isLoading = true;
  String? _error;
  List<bool> isSelected = [false, true, false];

  ProjectMembersProvider(this._projectsUsecase);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<bool> get getIsSelected => isSelected;

  void setIsSelected(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    notifyListeners();
  }

  //get the currently selected members list
  List<EmployeeTeamRole> getSelectedMembers() {
    if (isSelected[0]) {
      return pastMembers;
    } else if (isSelected[1]) {
      return activeMembers;
    } else {
      return futureMembers;
    }
  }

  // Add a member to the active members list
  void addActiveMember(EmployeeTeamRole member) {
    activeMembers.add(member);
  }

  // Add a member to the past members list
  void addPastMember(EmployeeTeamRole member) {
    pastMembers.add(member);
  }

  // Add a member to the future members list
  void addFutureMember(EmployeeTeamRole member) {
    futureMembers.add(member);
  }

  // Remove a member from the active members list
  void removeActiveMember(Employee member) {
    activeMembers.remove(member);
  }

  // Remove a member from the past members list
  void removePastMember(Employee member) {
    pastMembers.remove(member);
  }

  // Remove a member from the future members list
  void removeFutureMember(Employee member) {
    futureMembers.remove(member);
  }

  //get the active members list from use case
  Future<void> getActiveMembers(String projectId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final result = await _projectsUsecase.getActiveMembers(projectId);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      activeMembers = r;
      _isLoading = false;
      notifyListeners();
    });
  }

  //get the past members list from use case
  Future<void> getPastMembers(String projectId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final result = await _projectsUsecase.getInActiveMembers(projectId);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      pastMembers = List.from(r);
      _isLoading = false;
      notifyListeners();
    });
  }

  //get the future members list from use case
  Future<void> getFutureMembers(String projectId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final result = await _projectsUsecase.getFutureMembers(projectId);
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      futureMembers = r;
      _isLoading = false;
      notifyListeners();
    });
  }
}
