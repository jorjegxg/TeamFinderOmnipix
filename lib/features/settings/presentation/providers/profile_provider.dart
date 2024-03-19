import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart';

@singleton
class ProfileProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String newName = '';
  String newEmail = '';
  bool _isLoading = false;
  String? _error;
  final SettingsUseCase _settingsUseCase;

  ProfileProvider(this._settingsUseCase);

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setNewName(String name) {
    newName = name;
    notifyListeners();
  }

  void setNewEmail(String email) {
    newEmail = email;
    notifyListeners();
  }

  String get getName => name;
  String get getEmail => email;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get getNewName => newName;
  String get getNewEmail => newEmail;

  //fetch name and email
  Future<void> fetchNameAndEmail() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    //fetch current employee
    final result = await _settingsUseCase.getCurrentEmployee().then(
      (value) {
        value.fold(
          (l) {
            _error = l.message;
            _isLoading = false;
            notifyListeners();
          },
          (r) {
            name = r.name;
            email = r.email;
            _isLoading = false;
            notifyListeners();
          },
        );
      },
    );
    _isLoading = false;
    notifyListeners();
  }

  //update name and email
  Future<void> updateNameAndEmail() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    //update name and email

    await _settingsUseCase
        .updateNameAndEmail(getNewName, getNewEmail)
        .then((value) => value.fold(
              (l) {
                _error = l.message;
                _isLoading = false;
                notifyListeners();
              },
              (r) {
                _isLoading = false;
                name = getNewName;
                email = getNewEmail;
                notifyListeners();
                fetchNameAndEmail();
              },
            ));
  }

  //changePassword
  Future<void> changePassword(String newPassword, String newPassword2) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    //change password
    await _settingsUseCase
        .changePassword(newPassword, newPassword2, email)
        .then((value) {
      value.fold(
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

  void clearAllData() {
    name = '';
    email = '';
    newName = '';
    newEmail = '';
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
