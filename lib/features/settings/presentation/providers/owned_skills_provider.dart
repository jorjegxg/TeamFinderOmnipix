import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/departaments_pages/data/models/skill.dart';
import 'package:team_finder_app/features/settings/domain/usecases/settings_use_case.dart';

@injectable
class OwnedSkillsProvider extends ChangeNotifier {
  final SettingsUseCase _settingsUseCase;

  OwnedSkillsProvider(this._settingsUseCase);

  List<Skill> _skills = List.from([]);
  bool _isLoading = false;
  String? _error;

  List<Skill> get skills => _skills;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchOwnedSkills() async {
    _isLoading = true;
    notifyListeners();
    (await _settingsUseCase.getOwnedSkills()).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) {
        _skills = List.from(r);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  //delete skill
  Future<void> deleteSkill(Skill skill, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    (await _settingsUseCase.deleteOwnedSkill(skill)).fold(
      (l) {
        _error = l.message;
        _isLoading = false;
        notifyListeners();
      },
      (r) async {
        _skills.remove(skill);
        showSnackBar(context, 'Skill deleted');

        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
