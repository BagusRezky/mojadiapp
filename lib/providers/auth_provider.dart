import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mojadiapp/models/users_model.dart';
import 'package:mojadiapp/services/firebase_auth_service.dart';

class AuthProvider with ChangeNotifier {
  AppUser? _user;
  final AuthService _authService = AuthService();

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
      const snackBar = SnackBar(
        content: Text('Your email or password is incorrect'),
      );
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
      const snackBar = SnackBar(
        content: Text('Failed to register user'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
    } catch (e) {
      throw FirebaseAuthException(
          message: "Failed to send reset email", code: e.toString());
    }
  }
}
