import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class DetailsProvider extends ChangeNotifier {
  ProjectsUsecase _projectsUsecase;
  bool _canBeDeleted = false;

  bool get getCanBeDeleted => _canBeDeleted;

  DetailsProvider(this._projectsUsecase);

  //canBeDeleted
  Future<bool> canBeDeleted(String projectId) async {
    final response = await _projectsUsecase.canBeDeleted(projectId);
    return response.fold((l) => false, (r) {
      _canBeDeleted = r;
      notifyListeners();
      return r;
    });
  }
}
