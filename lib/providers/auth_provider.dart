// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mojadiapp/screens/home.dart';

// final fireAuth = FirebaseAuth.instance;

// class AuthProvider extends ChangeNotifier {
//   final formKey = GlobalKey<FormState>();

//   var isLogin = true;
//   var enteredEmail = '';
//   var enteredPassword = '';

//   Future<void> submit(
//       BuildContext context, String email, String password, bool isLogin) async {
//     try {
//       if (isLogin) {
//         await fireAuth.signInWithEmailAndPassword(
//             email: email, password: password);
//       } else {
//         await fireAuth.createUserWithEmailAndPassword(
//             email: email, password: password);
//       }
//       //
//     } catch (e) {
//       if (e is FirebaseAuthException) {
//         final snackBar =
//             SnackBar(content: Text(e.message ?? 'An error occurred'));
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       }
//     }

//     notifyListeners();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mojadiapp/models/users_model.dart';
import 'package:mojadiapp/services/firebase_auth_service.dart';

class AuthProvider with ChangeNotifier {
  AppUser? _user;
  AuthService _authService = AuthService();

  AppUser? get user => _user;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      _user = await _authService.signInWithEmail(email, password);
      notifyListeners();
      if (_user != null) {
        Navigator.pushNamed(context, '/home');
      } else {
        throw FirebaseAuthException(
            message: 'Failed to sign in', code: 'user-not-found');
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> register(String email, String password, String birthDate,
      String address, BuildContext context) async {
    try {
      _user = await _authService.registerWithEmail(
          email, password, birthDate, address);
      notifyListeners();
      if (_user != null) {
        Navigator.pushNamed(context, '/');
      } else {
        throw FirebaseAuthException(
            message: 'Failed to register', code: 'registration-failed');
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
