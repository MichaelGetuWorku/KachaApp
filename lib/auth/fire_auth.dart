import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String? name,
    required String? email,
    required String? password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    print('++++++++++++++++');
    print(email);
    print('++++++++++++++++');

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      print('++++++++++++++++');
      print(user);
      print('++++++++++++++++');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('++++++++++++++++');
        print('No user found for that email.');
        print('++++++++++++++++');
      } else if (e.code == 'wrong-password') {
        print('++++++++++++++++');
        print('Wrong password provided.');
        print('++++++++++++++++');
      }
    }

    return user;
  }
}