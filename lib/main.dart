import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const XefApp());
}

class XefApp extends StatelessWidget {
  const XefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xef',
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text(
            'Xef',
            style: TextStyle(fontSize: 62, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
