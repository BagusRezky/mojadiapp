import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mojadiapp/models/users_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AppUser?> signInWithEmail(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user != null
        ? AppUser(
            uid: user.uid,
            email: user.email!,
            displayName: user.displayName ?? '',
            birthDate: '',
            address: '')
        : null;
  }

  Future<AppUser?> registerWithEmail(
      String email, String password, String birthDate, String address) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;

    if (user != null) {
      await _db.collection('users').doc(user.uid).set({
        'email': email,
        'birthDate': birthDate,
        'address': address,
      });
      return AppUser(
          uid: user.uid,
          email: email,
          displayName: '',
          birthDate: birthDate,
          address: address);
    }
    return null;
  }
}
