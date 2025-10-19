import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'constants/Routes.dart';
import 'model/exceptions/KnownErrors.dart';


class SessionManager {
  static String? userId = null;
  static String? email = null;
  static String? password = null;
  static String? phoneNumber = null;
  static bool isLoggedIn = false;

  static KnownErrors? knownErrors = null;

  static FirebaseAuth? auth;

  static login(BuildContext context, FirebaseAuth auth, [String? password]) async {
    try {
      SessionManager.auth = auth;
      SessionManager.email = auth.currentUser!.email;
      SessionManager.phoneNumber = auth.currentUser!.phoneNumber;
      SessionManager.password = password;
      SessionManager.userId = auth.currentUser!.uid;
      SessionManager.isLoggedIn = true;
    } on Exception catch (e) {
      log("Exception Logging in: $e");
    }
  }

  static logout(BuildContext context) {
    SessionManager.email = null;
    SessionManager.phoneNumber = null;
    SessionManager.password = null;
    SessionManager.userId = null;
    SessionManager.isLoggedIn = false;
    SessionManager.auth = null;
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (r) => false);
  }


}
