import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectEntity projectEntity;

  const ProjectWidget({super.key, required this.projectEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFCAC4D0)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        height: 250,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(projectEntity.name,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Text(
                'Roles:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Project manager + ${projectEntity.projectManager}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Tehnologies:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                projectEntity.technologies.map((e) => e).join(', '),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  text: 'View Details',
                  onPressed: () {},
                  buttonHeight: 30,
                  buttonWidth: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
