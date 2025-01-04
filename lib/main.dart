import 'package:flutter/material.dart';
import 'package:taskmate/theme/dark_theme.dart';
import 'package:taskmate/theme/light_theme.dart';
import 'package:taskmate/utils/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMate',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
