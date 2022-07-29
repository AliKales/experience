import 'package:experiences/library/simple_uis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum LastProgress { signUp, logIn }

class AuthFirebase {
  static String lastEmail = "";
  static String lastPassword = "";
  static LastProgress? lastProgress;

  bool get isSignedIn =>
      FirebaseAuth.instance.currentUser == null ? false : true;

  String? get getEmail => FirebaseAuth.instance.currentUser?.email;
  String? get getUid => FirebaseAuth.instance.currentUser?.uid;

  Future<bool> signUp(
      BuildContext context, String emailAddress, String password) async {
    if ((lastProgress ?? true) != LastProgress.signUp) {
      lastEmail = "";
      lastPassword = "";
      lastProgress = LastProgress.signUp;
    }

    ///Here it saves last email and password if there's an error about it so on next try it checks if its same or not
    if (emailAddress == lastEmail) {
      _onAuthexception('email-already-in-use', password, context, emailAddress);
      return false;
    }
    if (password == lastPassword) {
      _onAuthexception('weak-password', password, context, emailAddress);
      return false;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      _onAuthexception(e.code, password, context, emailAddress);

      return false;
    } catch (e) {
      SimpleUIs().showSnackBar(context, "ERROR!");
      return false;
    }
  }

  void _onAuthexception(
      String e, String password, BuildContext context, String emailAddress) {
    if (e == 'weak-password') {
      lastPassword = password;
      SimpleUIs().showSnackBar(context, 'The password provided is too weak.');
    } else if (e == 'email-already-in-use') {
      lastEmail = emailAddress;
      SimpleUIs()
          .showSnackBar(context, "The account already exists for that email.");
    }
    if (e == 'user-not-found') {
      lastEmail = emailAddress;
      SimpleUIs().showSnackBar(context, 'No user found for that email.');
    } else if (e == 'wrong-password') {
      lastPassword = password;
      SimpleUIs()
          .showSnackBar(context, 'Wrong password provided for that user.');
    }
  }

  Future<bool> logIn(context, String emailAddress, String password) async {
    if ((lastProgress ?? true) != LastProgress.logIn) {
      lastEmail = "";
      lastPassword = "";
      lastProgress = LastProgress.logIn;
    }

    ///Here it saves last email and password if there's an error about it so on next try it checks if its same or not
    if (emailAddress == lastEmail) {
      _onAuthexception('email-already-in-use', password, context, emailAddress);
      return false;
    }
    if (password == lastPassword) {
      _onAuthexception('weak-password', password, context, emailAddress);
      return false;
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      _onAuthexception(e.code, password, context, emailAddress);
      return false;
    }
  }

  Future<bool> logOut(context) async {
    await FirebaseAuth.instance.signOut();
    return true;
  }
}
