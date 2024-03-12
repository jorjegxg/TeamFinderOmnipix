import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectEntity projectEntity;

  const ProjectWidget({super.key, required this.projectEntity});
=======
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
    super.key,
    required this.mainTitle,
    required this.title1,
    required this.title2,
    required this.content1,
    required this.content2,
    required this.onPressed,
    this.onLongPress,
  });
>>>>>>> main

  final String mainTitle;
  final String title1;
  final String title2;
  final String content1;
  final String content2;
  final Function() onPressed;
  final Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
<<<<<<< HEAD
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
=======
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
                  child: Text(mainTitle,
                      style: Theme.of(context).textTheme.titleMedium),
>>>>>>> main
                ),
                const SizedBox(height: 10),
                const Divider(),
                Text(
                  title1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  content1,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  title2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  content2,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    text: 'View Details',
                    onPressed: onPressed,
                    buttonHeight: 30,
                    buttonWidth: 60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
