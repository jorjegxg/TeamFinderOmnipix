import 'package:flutter/material.dart';

class DepartamentDetailsPage extends StatelessWidget {
  const DepartamentDetailsPage(
      {super.key, required this.departamentId, required this.userId});

  final String departamentId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Departaments',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
