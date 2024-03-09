import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:responsive_builder/responsive_builder.dart';
import 'package:team_finder_app/core/routes/app_route_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
  } else {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<String>('authBox');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: MyAppRouter().router,
          title: 'Flutter Demo',
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
                onPressed: () => postData(),
                child: const Text('Elevated Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> postData() async {
  // const authToken =
  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcwOTI5MTk5MSwianRpIjoiN2I0MmQyZjktNmQwMC00ZmQ5LTlmMjAtMDJjYzJiMzRlZGRjIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImU5V050Rk0zSkxiOVh3enpIVE9hIiwibmJmIjoxNzA5MjkxOTkxLCJleHAiOjE3MTE4ODM5OTEsImlkIjoiZTlXTnRGTTNKTGI5WHd6ekhUT2EiLCJuYW1lIjoic3RyaW5nIiwid29ya2luZ0hvdXJzIjowLCJlbWFpbCI6InN0cmluZyIsIm9yZ2FuaXphdGlvbklkIjoiR01IVXZmb040aE9jZllBT3B2TVIiLCJkZXBhcnRhbWVudElkIjoibnVsbCJ9.Qsj4FmmI7M1-FxCSnjJ3tF04N-V-3LeSxEVttrDA8wI';

  try {
    // Define the JSON data
    Map<String, dynamic> data = {
      "name": "string",
      "email": "c@c.com",
      "password": "string",
      "organizationName": "stringus",
      "adress": "string",
      "url": "string/fsef"
    };

    // Create Dio instance
    Dio dio = Dio();

    // Make POST request
    Response response = await dio.post(
      'https://omnipix.azurewebsites.net/admin/create',
      data: data,
    );

    log('Response: $response');

    // Check response status
    if (response.statusCode == 200) {
      log('Success! Data posted.');
    } else {
      log('Error: ${response.statusCode}');
    }
  } catch (error) {
    log('Error: $error');
  }
}
