import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kacha/firebase_options.dart';
import 'package:kacha/screens/home_screen.dart';
import 'package:kacha/screens/login_screen.dart';
import 'package:kacha/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const LoginScreen(),
    );
  }

  ThemeData theme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      useMaterial3: true,
    );
  }
}
