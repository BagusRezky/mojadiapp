import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mojadiapp/screens/home.dart';

final fireAuth = FirebaseAuth.instance;

class AuthProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  var isLogin = true;
  var enteredEmail = '';
  var enteredPassword = '';

  Future<void> submit(
      BuildContext context, String email, String password, bool isLogin) async {
    try {
      if (isLogin) {
        await fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await fireAuth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      // 
    } catch (e) {
      if (e is FirebaseAuthException) {
        final snackBar =
            SnackBar(content: Text(e.message ?? 'An error occurred'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    notifyListeners();
  }
}
