import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class SendProposalProvider extends ChangeNotifier {
  // Add your provider properties and methods here
  final ProjectsUsecase _projectsUsecase;

  SendProposalProvider(this._projectsUsecase);
  // Example property
  String _proposal = '';
  bool _isLoading = false;
  String? _error;
  int _workHours = 1;
  ProjectEntity? _project;
  List<TeamRole> _teamRoles = List.from([]);
  TeamRole? _selectedDropValue;

  String get proposal => _proposal;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get getWorkHours => _workHours;
  ProjectEntity? get getProject => _project;
  List<TeamRole> get getTeamRoles => _teamRoles;
  TeamRole? get getSelectedDropValue => _selectedDropValue;

  set proposal(String value) {
    _proposal = value;
    notifyListeners();
  }

  set workHours(int value) {
    _workHours = value;
    notifyListeners();
  }

  set teamRoles(List<TeamRole> value) {
    _teamRoles = value;

    notifyListeners();
  }

  set project(ProjectEntity value) {
    _project = value;

    _selectedDropValue = _project!.teamRoles.keys.first;
    notifyListeners();
  }

  void removeTeamRole(String s) {
    _teamRoles.removeWhere((element) => element.name == s);
    notifyListeners();
  }

  void addTeamRole(String s) {
    if (_teamRoles.contains(
        _project!.teamRoles.keys.firstWhere((element) => element.name == s))) {
      return;
    }
    _teamRoles.add(
        _project!.teamRoles.keys.firstWhere((element) => element.name == s));
    notifyListeners();
  }

  Future<void> sendProposal(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final result = await _projectsUsecase.sendProposal(
      project: _project!,
      proposal: _proposal,
      workHours: _workHours,
      teamRoles: _teamRoles,
    );
    result.fold((l) {
      _error = l.message;
      _isLoading = false;
      notifyListeners();
    }, (r) {
      showSnackBar(context, 'Proposal sent successfully');
      _isLoading = false;
      notifyListeners();
    });
  }
}
