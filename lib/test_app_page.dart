import 'package:flutter/material.dart';

class TestAppPage extends StatelessWidget {
  const TestAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {},
            child: Text(
              'Apasa-ma',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}
