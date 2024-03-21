import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/bloc_observer.dart';
import 'package:team_finder_app/core/routes/app_route_config.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/core/util/theme.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/delete_department_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departament_skills_provider.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';
import 'package:team_finder_app/features/employee_pages/presentation/provider/employee_roles_provider.dart';
import 'package:team_finder_app/features/project_pages/data/models/team_role.dart';
import 'package:team_finder_app/features/project_pages/data/models/technology_stack.dart';
import 'package:team_finder_app/features/project_pages/domain/entities/project_entity.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/projects_bloc.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/add_member_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/create_project_provider.dart';
import 'package:team_finder_app/features/project_pages/presentation/providers/edit_project_provider.dart';
import 'package:team_finder_app/features/settings/presentation/providers/profile_provider.dart';
import 'package:team_finder_app/firebase_options.dart';
import 'package:team_finder_app/injection.dart';
import 'package:url_strategy/url_strategy.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   Logger.info(
//       '_firebaseMessagingBackgroundHandler', 'Got a message in background!');
//   Logger.info(
//       '_firebaseMessagingBackgroundHandler', 'Message data: ${message.data}');

//   if (message.notification != null) {
//     Logger.info('_firebaseMessagingBackgroundHandler',
//         'Message also contained a notification: ${message.notification}');
//   }
// }

Future<void> main() async {
  setPathUrlStrategy();
  configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // Logger.info(
  //     'main()', 'User granted permission: ${settings.authorizationStatus}');

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // Logger.info('main()', 'FCM Token: $fcmToken');

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (kIsWeb) {
    Hive.initFlutter();
  } else {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }
  Hive.registerAdapter(ProjectEntityAdapter());
  Hive.registerAdapter(TechnologyStackAdapter());
  Hive.registerAdapter(TeamRoleAdapter());
  Hive.registerAdapter(ProjectPeriodAdapter());

  await Hive.openBox<String>(HiveConstants.authBox);
  await Hive.openBox<ProjectEntity>(HiveConstants.projectEntityBox);
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    //TODO George Luta : handle the message
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt<DepartamentSkillsProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<AddMembersProvider>(),
        ),
        ChangeNotifierProvider(
            create: (context) => getIt<EditProjectProvider>()),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DepartmentCreateCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<DepartmentsGetCubit>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<ProfileProvider>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ProjectsBloc>()..add(const GetActiveProjectPages()),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<EmployeeRolesProvider>(),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<DeleteDepartmentProvider>(),
        ),
        ChangeNotifierProvider(
            create: (context) => getIt<CreateProjectProvider>()),
      ],
      child: ResponsiveApp(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: getIt<MyAppRouter>().router,
            title: 'Flutter Demo',
            theme: createLightTheme(),
          );
        },
      ),
    );
  }
}
