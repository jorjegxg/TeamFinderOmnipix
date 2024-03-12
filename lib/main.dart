import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:responsive_builder/responsive_builder.dart';

import 'package:team_finder_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:team_finder_app/injection.dart';
import 'package:team_finder_app/core/routes/app_route_config.dart';
import 'package:team_finder_app/core/util/theme.dart';

// import 'injectable.config.dart';

Future<void> main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  // GetIt.I.registerSingleton<MyAppRouter>(MyAppRouter());
  if (kIsWeb) {
  } else {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<String>('authBox');
  }

  // runApp(const TestAppPage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
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
