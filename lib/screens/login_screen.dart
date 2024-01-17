import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kacha/component/login/form.dart';
import 'package:kacha/screens/profile_screen.dart';
import 'package:kacha/screens/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  void initState() {
    // TODO: implement initState
    _initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget helpInfoContainer = SizedBox(
      width: double.infinity,
      height: 36,
      child: Center(
        child: InkWell(
          onTap: getLoginHelp,
          child: const Text(
            'Having trouble logging in?',
            style: TextStyle(fontSize: 14, color: Color(0xFF929BAB)),
          ),
        ),
      ),
    );

    Widget signUpContainer = SizedBox(
      width: double.infinity,
      height: 36,
      child: Center(
        child: InkWell(
          onTap: goToSignUpScreen,
          child: const Text(
            'Sign up',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF929BAB),
            ),
          ),
        ),
      ),
    );
    List<Widget> loginScreenContents = <Widget>[
      _spacing(64),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.asset(
            'assets/images/hadwin_system/hadwin-logo-with-name.png'),
      ),
      _spacing(64),
      const LoginFormComponent(),
      _spacing(30),
      helpInfoContainer,
      _spacing(10),
      signUpContainer
    ];
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(45),
        child: Column(
          children: loginScreenContents,
        ),
      ),
    );
  }

  void getLoginHelp() {
    // Navigator.push(
    //   context,
    //   SlideRightRoute(
    //     page: HadWinMarkdownViewer(
    //         screenName: 'Login Help',
    //         urlRequested:
    //             'https://raw.githubusercontent.com/brownboycodes/HADWIN/master/docs/HADWIN_WIKI.md'),
    //   ),
    // );
  }

  void goToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  SizedBox _spacing(double height) => SizedBox(
        height: height,
      );
}
