import 'package:flutter/foundation.dart';

class ChangePasswordProvider with ChangeNotifier {
  String _newPassword = '';
  bool _isLoading = false;
  String? _error;

  String get newPassword => _newPassword;

  void setNewPassword(String password) {
    _newPassword = password;
    notifyListeners();
  }

  void changePassword() {
    _isLoading = true;
    _error = null;
    notifyListeners();
  }
}
