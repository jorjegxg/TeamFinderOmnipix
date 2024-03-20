import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart';

@injectable
class PersonalSkillsProvider extends ChangeNotifier {
  final SettingsUseCase _settingsUseCase;

  PersonalSkillsProvider(this._settingsUseCase);

  List<Skill> _skills = [];
  bool _canCreate = true;
  bool _isLoading = false;
  String? _error;

  List<Skill> get skills => _skills;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSkillsForEmployee(String departamentId) async {
    _isLoading = true;
    notifyListeners();
    (await _settingsUseCase.getSkillsForEmployee()).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _skills = r;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
