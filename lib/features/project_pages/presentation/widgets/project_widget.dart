import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/register_button.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({super.key});

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
                child: Text('Project Name',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Text(
                'Roles:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Project manager',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Tehnologies:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'List of tehnologies:',
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
