import 'package:flutter/material.dart';
import 'package:kacha/screens/home_screen.dart';
import 'package:kacha/screens/login_screen.dart';
import 'package:kacha/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const ProfileScreen(),
    );
  }

  ThemeData theme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      useMaterial3: true,
    );
  }
}
