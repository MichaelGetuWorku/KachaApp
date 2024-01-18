import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kacha/firebase_options.dart';
import 'package:kacha/screens/home_screen.dart';
import 'package:kacha/screens/login_screen.dart';
import 'package:kacha/screens/profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kacha/state/user_state.dart';
import 'package:provider/provider.dart';

bool shouldUseFirestoreEmulator = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  runApp(
    ChangeNotifierProvider(
      child: const MyApp(),
      create: (context) => UserData(),
    ),
  );
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
