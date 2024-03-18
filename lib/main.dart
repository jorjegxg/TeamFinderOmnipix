import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/bloc_observer.dart';
import 'package:team_finder_app/core/routes/app_route_config.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/theme.dart';
import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_create/department_create_cubit.dart';
import 'package:team_finder_app/features/departaments_pages/presentation/cubit/departments_get/departments_get_cubit.dart';
import 'package:team_finder_app/features/project_pages/presentation/bloc/create_project_provider.dart';
import 'package:team_finder_app/firebase_options.dart';
import 'package:team_finder_app/injection.dart';
import 'package:url_strategy/url_strategy.dart';

// import 'injectable.config.dart';

Future<void> main() async {
  setPathUrlStrategy();
  configureDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // GetIt.I.registerSingleton<MyAppRouter>(MyAppRouter());
  if (kIsWeb) {
  } else {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<String>(HiveConstants.authBox);
  }

  Bloc.observer = MyBlocObserver();

  // runApp(const TestAppPage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                getIt<CreateProjectProvider>()..getTeamRoles()),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DepartmentCreateCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<DepartmentsGetCubit>(),
        ),
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
