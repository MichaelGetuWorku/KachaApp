import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kacha/auth/fire_auth.dart';
import 'package:kacha/component/login/form.dart';
import 'package:kacha/screens/home_screen.dart';
import 'package:kacha/screens/profile_screen.dart';
import 'package:kacha/screens/sign_up_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage1 = "";
  String errorMessage2 = "";
  String userInput = "";

  void errorMessageSetter(int fieldNumber, String message) {
    setState(() {
      if (fieldNumber == 1) {
        errorMessage1 = message;
      } else {
        errorMessage2 = message;
      }
    });
  }

  void tryLoggingIn() async {
    if (_formKey.currentState!.validate()) {
      await FireAuth.resetPassword(email: userInput);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent. Please check your email.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> loginScreenContents = <Widget>[
      _spacing(64),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.asset(
          'assets/images/kacha.png',
          // scale: 1,
        ),
      ),
      _spacing(64),
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Color(0xFFF5F7FA)),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 6.18,
                    spreadRadius: 0.618,
                    offset: Offset(-4, -4),
                    // color: Colors.white38
                    color: Color(0xFFF5F7FA),
                  ),
                  BoxShadow(
                      blurRadius: 6.18,
                      spreadRadius: 0.618,
                      offset: const Offset(4, 4),
                      color: Colors.blueGrey.shade100
                      // color: Color(0xFFF5F7FA)
                      )
                ],
              ),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    errorMessageSetter(
                        1, 'you must provide a email-id or username');
                  } else {
                    errorMessageSetter(1, "");

                    setState(() {
                      userInput = value;
                    });
                  }

                  return null;
                },
                autocorrect: false,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Username or Email address",
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey.shade100,
                      offset: const Offset(0, 4),
                      blurRadius: 5.0)
                ],
                gradient: const RadialGradient(
                    colors: [Color(0xff0070BA), Color(0xff1546A0)],
                    radius: 8.4,
                    center: Alignment(-0.24, -0.36)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                  onPressed: _validateLoginDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
      // _spacing(30),
    ];
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(45),
        child: Column(
          children: loginScreenContents,
        ),
      ),
    );
  }

  void getLoginHelp() {
    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const ForgetPasswordScreen(),
      ),
    );
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

  void _validateLoginDetails() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      if (errorMessage1 != "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide all required details'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              onVisible: tryLoggingIn,
              content: const Text('Processing...'),
              backgroundColor: Colors.blue),
        );
      }
    }
  }
}
