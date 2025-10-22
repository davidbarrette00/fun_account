import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'dart:developer' as developer;

import '../constants/Routes.dart';
import '../model/registering_user.dart';
import '../session_manager.dart';

class LoginAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String?> registerNewUser(BuildContext context, RegisteringUser registeringUser) async {

    UserCredential? user;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: registeringUser.email, password: registeringUser.password);
    } on FirebaseAuthException catch (e) {
      print("Error registering new user: $e");
      return e.message;
    }

    _auth.currentUser?.updateDisplayName(registeringUser.firstName + registeringUser.lastName);
    SessionManager.login(context, _auth, registeringUser.password);
    Navigator.pushNamed(context, Routes.home);
  }

  static Future<String?> deleteUser(BuildContext context, RegisteringUser registeringUser) async {
    try {
      await _auth.currentUser?.delete();

    } on FirebaseAuthException catch (e) {
      print("Error deleting user: $e");
      return e.message;
    }

    SessionManager.logout(context);
  }

  static Future<UserCredential?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    UserCredential? user;

    await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    SessionManager.login(context, _auth, password);
    Navigator.pushNamed(context, Routes.home);
  }

  // static Future<UserCredential?>  signInWithGoogle(){
  //   return _auth.;
  // }
}
