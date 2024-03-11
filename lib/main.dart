import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/test_app_page.dart';
import 'package:team_finder_app/core/routes/app_route_config.dart';
import 'package:team_finder_app/core/util/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<MyAppRouter>(MyAppRouter());
  if (kIsWeb) {
  } else {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<String>('authBox');
  }

  runApp(const TestAppPage());
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: GetIt.I<MyAppRouter>().router,
          title: 'Flutter Demo',
          theme: createLightTheme(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
