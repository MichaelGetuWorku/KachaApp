import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? newUser) {
    _user = newUser;
    notifyListeners();
  }
}
