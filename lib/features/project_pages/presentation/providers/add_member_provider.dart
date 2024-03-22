import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/employee_pages/data/models/employee.dart';
import 'package:team_finder_app/features/project_pages/domain/usecases/projects_usecase.dart';

@injectable
class AddMembersProvider extends ChangeNotifier {
  final ProjectsUsecase _projectsUsecase;
  List<Employee> members = [];
  bool _isLoading = true;
  String? _error;
  bool partialyAvabile = false;
  bool unAvabile = false;
  bool closeToFinish = false;
  int noOfWeeks = 0;

  AddMembersProvider(this._projectsUsecase);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Employee> get getMembers => members;
  bool get getPartialyAvabile => partialyAvabile;
  bool get getUnAvabile => unAvabile;
  bool get getCloseToFinish => closeToFinish;
  int get getNoOfWeeks => noOfWeeks;

  //set
  set setPartialyAvabile(bool value) {
    partialyAvabile = value;
    notifyListeners();
  }

  //reset all
  void resetAll() {
    partialyAvabile = false;
    unAvabile = false;
    closeToFinish = false;
    noOfWeeks = 0;
    notifyListeners();
  }

  set setUnAvabile(bool value) {
    unAvabile = value;
    notifyListeners();
  }

  set setCloseToFinish(bool value) {
    closeToFinish = value;
    notifyListeners();
  }

  set setNoOfWeeks(int value) {
    noOfWeeks = value;
    notifyListeners();
  }

  void setMembers(List<Employee> value) {
    members = value;
    notifyListeners();
  }

  //add
  void addMember(Employee member) {
    members.add(member);
    notifyListeners();
  }

  //fetch members
  Future<void> fetchMembers(String projectId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    if (!getUnAvabile && !getPartialyAvabile && !getCloseToFinish) {
      final response =
          await _projectsUsecase.fetchFullyAvalibleMembers(projectId);
      response.fold(
        (l) {
          _error = l.message;
          _isLoading = false;
          notifyListeners();
        },
        (r) {
          members = r;
          _isLoading = false;
          notifyListeners();
        },
      );
    } else {
      members = [];
      if (getPartialyAvabile) {
        final response =
            await _projectsUsecase.fetchPartialyAvabileMembers(projectId);
        response.fold(
          (l) {
            _error = l.message;
            _isLoading = false;
            notifyListeners();
          },
          (r) {
            members.addAll(r);
            _isLoading = false;
            notifyListeners();
          },
        );
      }
      if (getUnAvabile) {
        final response =
            await _projectsUsecase.fetchUnavailableMembers(projectId);
        response.fold(
          (l) {
            _error = l.message;
            _isLoading = false;
            notifyListeners();
          },
          (r) {
            members.addAll(r);
            _isLoading = false;
            notifyListeners();
          },
        );
      } else {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  //fetch members with chatGPT
  Future<void> fetchMembersWithChatGPT(
      String description, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response =
        await _projectsUsecase.fetchMembersWithChatGPT(description);
    response.fold(
      (l) {
        if (l is ServerFailure) {
          if ((l as ServerFailure).statusCode != null &&
              (l as ServerFailure).statusCode == 500) {
            _error = l.message;
            _isLoading = false;
            showSnackBar(context, "Backend failure");
          }
        } else {
          _error = l.message;
          _isLoading = false;
          showSnackBar(context, l.message);
          notifyListeners();
        }
      },
      (r) {
        members = List.from(r);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void clearAllData() {
    members = [];
    _isLoading = true;
    _error = null;
    notifyListeners();
  }
}
