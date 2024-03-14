import 'package:flutter/material.dart';
import 'package:team_finder_app/features/auth/presentation/widgets/custom_button.dart';

class RequestsCard extends StatelessWidget {
  const RequestsCard({
    super.key,
    required this.mainTitle,
    required this.text1,
    this.text3,
    required this.text2,
    required this.onPressed,
    required this.onPressed2,
  });

  final String mainTitle;
  final String text1;
  final String? text3;
  final String text2;

  final Function() onPressed;
  final Function() onPressed2;
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
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(mainTitle,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    text2,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (text3 != null)
                    Text(
                      text3!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: 'Refuse',
                      onPressed: onPressed,
                      buttonHeight: 30,
                      buttonWidth: 60,
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      text: 'Accept',
                      onPressed: onPressed2,
                      buttonHeight: 30,
                      buttonWidth: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
