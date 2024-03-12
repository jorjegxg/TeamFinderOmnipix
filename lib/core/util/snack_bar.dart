import 'package:flutter/material.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
