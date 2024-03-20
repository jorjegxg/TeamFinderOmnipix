import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/settings/data/models/role_model.dart';
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart';

@injectable
class TeamRolesProvider extends ChangeNotifier {
  final SettingsUseCase _settingsUseCase;
  TeamRolesProvider(this._settingsUseCase);

  bool _isLoading = false;
  String? _error;
  List<RoleModel> _teamRoles = [];

  List<RoleModel> get teamRoles => _teamRoles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void addTeamRole(String role) {
    _teamRoles.add(RoleModel(name: role, id: ''));
    notifyListeners();
  }

  void removeTeamRole(String role) {
    _teamRoles.remove(_teamRoles.firstWhere((element) => element.name == role));
    notifyListeners();
  }

  Future<void> getTeamRoles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await _settingsUseCase.getTeamRoles().then((response) {
      response.fold(
        (l) {
          _error = l.message;
          _isLoading = false;
          notifyListeners();
        },
        (r) {
          _teamRoles = List.from(r);
          _isLoading = false;
          notifyListeners();
        },
      );
    });
    notifyListeners();
  }

  //add team role
  Future<void> addRole(RoleModel role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await _settingsUseCase.addTeamRole(role).then((response) {
      response.fold(
        (l) {
          _error = l.message;
          _isLoading = false;
          notifyListeners();
        },
        (r) {
          _isLoading = false;
          notifyListeners();
        },
      );
    });
  }

  //delete team role
  Future<void> deleteRole(RoleModel role, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await _settingsUseCase.deleteTeamRole(role).then((response) {
      response.fold(
        (l) {
          _error = l.message;
          _isLoading = false;
          notifyListeners();
        },
        (r) {
          _isLoading = false;
          teamRoles.remove(role);
          showSnackBar(context, r);
          notifyListeners();
        },
      );
    });
  }

  Future<void> editRole(RoleModel roleModel, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    await _settingsUseCase.editRole(roleModel).then((response) {
      response.fold(
        (l) {
          _error = l.message;
          _isLoading = false;
          notifyListeners();
        },
        (r) {
          _isLoading = false;
          showSnackBar(context, "Role edited successfully");
          notifyListeners();
        },
      );
    });
  }
}
