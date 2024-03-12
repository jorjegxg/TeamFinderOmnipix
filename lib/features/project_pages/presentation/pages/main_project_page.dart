import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:team_finder_app/core/routes/app_route_const.dart';
import 'package:team_finder_app/core/util/snack_bar.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/custom_segmented_button.dart';
import 'package:team_finder_app/features/project_pages/presentation/widgets/project_widget.dart';

class ProjectsMainScreen extends StatelessWidget {
  const ProjectsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectsBloc, ProjectsState>(
      listener: (context, state) {
        if (state is ProjectsError) {
          showSnackBar(context, state.message);
        }
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.goNamed(AppRouterConst.createProjectScreen);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Projects',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(child: CustomSegmentedButton()),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<ProjectsBloc, ProjectsState>(
                    builder: (context, state) {
                      if (state is ProjectsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is ProjectsLoaded) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.projects.length,
                            itemBuilder: (context, index) {
                              return ProjectWidget(
                                projectEntity: state.projects[index],
                              );
                            },
                          ),
                        );
                      }

                      if (state is ProjectsError) {
                        return Center(
                          child:
                              Text('Error loading projects : ${state.message}'),
                        );
                      }

                      return const Center(
                        child: Text('No projects found'),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('Day'),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('Week'),
            icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text('Month'),
            icon: Icon(Icons.calendar_view_month)),
        ButtonSegment<Calendar>(
            value: Calendar.year,
            label: Text('Year'),
            icon: Icon(Icons.calendar_today)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

// Column(
//           children: [
//             Container(
//               width: 362,
//               height: 800,
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(color: Color(0xFFFEF7FF)),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 0,
//                     top: 0,
//                     child: Container(
//                       width: 362,
//                       height: 61,
//                       decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
//                     ),
//                   ),
//                   Positioned(
//                     left: 73,
//                     top: 19,
//                     child: SizedBox(
//                       width: 187,
//                       height: 30,
//                       child: Text(
//                         'Your Projects',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 22,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w400,
//                           height: 0.06,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     top: 749,
//                     child: Container(
//                       width: 350,
//                       height: 54,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 350,
//                               height: 54,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: Container(
//                                       width: 350,
//                                       height: 54,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8),
//                                       decoration: BoxDecoration(
//                                           color: Color(0xFFF3EDF7)),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [],
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 40,
//                                     top: 11,
//                                     child: Container(
//                                       width: 35,
//                                       height: 32,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: NetworkImage(
//                                               "https://via.placeholder.com/35x32"),
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 242,
//                             top: 12,
//                             child: Container(
//                               width: 33,
//                               height: 32,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 291,
//                     top: 761,
//                     child: Container(
//                       width: 33,
//                       height: 32,
//                       child: Stack(children: []),
//                     ),
//                   ),
//                   Positioned(
//                     left: 125,
//                     top: 757,
//                     child: Container(
//                       width: 35,
//                       height: 38,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image:
//                               NetworkImage("https://via.placeholder.com/35x38"),
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 211,
//                     top: 750,
//                     child: Container(
//                       width: 37,
//                       height: 51,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image:
//                               NetworkImage("https://via.placeholder.com/37x51"),
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 56,
//                     top: 105,
//                     child: Container(
//                       width: 251,
//                       height: 48,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Container(
//                               height: 48,
//                               padding: const EdgeInsets.symmetric(vertical: 4),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: double.infinity,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: ShapeDecoration(
//                                         color: Color(0xFFE8DEF8),
//                                         shape: RoundedRectangleBorder(
//                                           side: BorderSide(
//                                               width: 1,
//                                               color: Color(0xFF79747E)),
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(100),
//                                             bottomLeft: Radius.circular(100),
//                                           ),
//                                         ),
//                                       ),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               width: double.infinity,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 10),
//                                               child: Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                     'Active Projects',
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       color: Color(0xFF1D192B),
//                                                       fontSize: 14,
//                                                       fontFamily: 'Roboto',
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       height: 0.10,
//                                                       letterSpacing: 0.10,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               height: 48,
//                               padding: const EdgeInsets.symmetric(vertical: 4),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: double.infinity,
//                                       clipBehavior: Clip.antiAlias,
//                                       decoration: ShapeDecoration(
//                                         shape: RoundedRectangleBorder(
//                                           side: BorderSide(
//                                               width: 1,
//                                               color: Color(0xFF79747E)),
//                                           borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(100),
//                                             bottomRight: Radius.circular(100),
//                                           ),
//                                         ),
//                                       ),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               width: double.infinity,
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 10),
//                                               child: Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                     'Past Projects',
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                       color: Color(0xFF1D1B20),
//                                                       fontSize: 14,
//                                                       fontFamily: 'Roboto',
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       height: 0.10,
//                                                       letterSpacing: 0.10,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 19,
//                     top: 189,
//                     child: Container(
//                       width: 327,
//                       height: 284,
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 327,
//                             height: 284,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: ShapeDecoration(
//                               shape: RoundedRectangleBorder(
//                                 side: BorderSide(
//                                     width: 1, color: Color(0xFFCAC4D0)),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: double.infinity,
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: double.infinity,
//                                           height: 72,
//                                           padding: const EdgeInsets.only(
//                                             top: 12,
//                                             left: 16,
//                                             right: 4,
//                                             bottom: 12,
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Expanded(
//                                                 child: Container(
//                                                   height: 24,
//                                                   child: Row(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Expanded(
//                                                         child: Container(
//                                                           child: Column(
//                                                             mainAxisSize:
//                                                                 MainAxisSize
//                                                                     .min,
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .start,
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               SizedBox(
//                                                                 width: double
//                                                                     .infinity,
//                                                                 child: Text(
//                                                                   'Project Name',
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Color(
//                                                                         0xFF1D1B20),
//                                                                     fontSize:
//                                                                         16,
//                                                                     fontFamily:
//                                                                         'Roboto',
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500,
//                                                                     height:
//                                                                         0.09,
//                                                                     letterSpacing:
//                                                                         0.15,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           width: 327,
//                                           height: 1,
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 width: 327,
//                                                 height: 1,
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                     image: NetworkImage(
//                                                         "https://via.placeholder.com/327x1"),
//                                                     fit: BoxFit.fill,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           width: double.infinity,
//                                           height: 220,
//                                           padding: const EdgeInsets.all(16),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 width: double.infinity,
//                                                 height: 44,
//                                                 child: Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     SizedBox(
//                                                       width: 328,
//                                                       child: Text(
//                                                         'Roles:',
//                                                         style: TextStyle(
//                                                           color:
//                                                               Color(0xFF1D1B20),
//                                                           fontSize: 16,
//                                                           fontFamily: 'Roboto',
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           height: 0.09,
//                                                           letterSpacing: 0.50,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 328,
//                                                       child: Text(
//                                                         'Project manager',
//                                                         style: TextStyle(
//                                                           color:
//                                                               Color(0xFF49454F),
//                                                           fontSize: 14,
//                                                           fontFamily: 'Roboto',
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           height: 0.10,
//                                                           letterSpacing: 0.25,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 32),
//                                               SizedBox(
//                                                 width: double.infinity,
//                                                 child: Text(
//                                                   'Technologies Stack:\ntechnologies...',
//                                                   style: TextStyle(
//                                                     color: Color(0xFF49454F),
//                                                     fontSize: 14,
//                                                     fontFamily: 'Roboto',
//                                                     fontWeight: FontWeight.w400,
//                                                     height: 0.10,
//                                                     letterSpacing: 0.25,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(height: 32),
//                                               Container(
//                                                 width: double.infinity,
//                                                 child: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Container(
//                                                       height: 40,
//                                                       clipBehavior:
//                                                           Clip.antiAlias,
//                                                       decoration:
//                                                           ShapeDecoration(
//                                                         color:
//                                                             Color(0xFF6750A4),
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       100),
//                                                         ),
//                                                       ),
//                                                       child: Column(
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Expanded(
//                                                             child: Container(
//                                                               width: double
//                                                                   .infinity,
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .symmetric(
//                                                                       horizontal:
//                                                                           24,
//                                                                       vertical:
//                                                                           10),
//                                                               child: Row(
//                                                                 mainAxisSize:
//                                                                     MainAxisSize
//                                                                         .min,
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   Text(
//                                                                     'View Details',
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontSize:
//                                                                           14,
//                                                                       fontFamily:
//                                                                           'Roboto',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                       height:
//                                                                           0.10,
//                                                                       letterSpacing:
//                                                                           0.10,
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             width: 327,
//                             height: 284,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: ShapeDecoration(
//                               color: Color(0xFFFEF7FF),
//                               shape: RoundedRectangleBorder(
//                                 side: BorderSide(
//                                     width: 1, color: Color(0xFFCAC4D0)),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: 327,
//                                   height: 284,
//                                   padding: const EdgeInsets.all(10),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 291,
//                     top: 675,
//                     child: Container(
//                       width: 58,
//                       height: 56,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 0,
//                             top: 0,
//                             child: Container(
//                               width: 58,
//                               height: 56,
//                               decoration: ShapeDecoration(
//                                 color: Color(0xFFD9D9D9),
//                                 shape: OvalBorder(),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 6,
//                             top: 8,
//                             child: Container(
//                               width: 48,
//                               height: 40,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(),
//                               child: Stack(children: []),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
 