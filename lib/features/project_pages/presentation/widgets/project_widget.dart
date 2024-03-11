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
            side: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
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
              SizedBox(height: 10),
              Divider(),
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

class StackedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 327,
          height: 284,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 327,
                height: 284,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 72,
                              padding: const EdgeInsets.only(
                                top: 12,
                                left: 16,
                                right: 4,
                                bottom: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 24,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      'Project Name',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF1D1B20),
                                                        fontSize: 16,
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.09,
                                                        letterSpacing: 0.15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 327,
                              height: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 327,
                                    height: 1,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/327x1"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 220,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 44,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 328,
                                          child: Text(
                                            'Roles:',
                                            style: TextStyle(
                                              color: Color(0xFF1D1B20),
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0.09,
                                              letterSpacing: 0.50,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 328,
                                          child: Text(
                                            'Project manager',
                                            style: TextStyle(
                                              color: Color(0xFF49454F),
                                              fontSize: 14,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              height: 0.10,
                                              letterSpacing: 0.25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'Technologies Stack:\ntechnologies...',
                                      style: TextStyle(
                                        color: Color(0xFF49454F),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0.10,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF6750A4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 24,
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'View Details',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0.10,
                                                          letterSpacing: 0.10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 327,
                height: 284,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFFEF7FF),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFCAC4D0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 327,
                      height: 284,
                      padding: const EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
