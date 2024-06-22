import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mojadiapp/models/users_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
        'uid': user.uid,
        'email': email,
        'birthDate': birthDate,
        'address': address,
        'displayName': user.displayName ?? ''
      });
      return AppUser(
          uid: user.uid,
          email: email,
          displayName: user.displayName ?? '',
          birthDate: birthDate,
          address: address);
    }
    return null;
  }

  Future<AppUser?> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      if (user != null) {
        // Check if user already exists in database, if not create a new one
        DocumentSnapshot doc =
            await _db.collection('users').doc(user.uid).get();
        if (!doc.exists) {
          await _db.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName ?? '',
          });
        }
        return AppUser(
            uid: user.uid,
            email: user.email!,
            displayName: user.displayName ?? '',
            birthDate: '',
            address: '');
      }
    }
    return null;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<AppUser?> getUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _db.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return AppUser(
          uid: doc['uid'],
          email: doc['email'],
          displayName: doc['displayName'] ?? '',
          birthDate: doc['birthDate'] ?? '',
          address: doc['address'] ?? '',
        );
      } else {
        throw Exception('User profile not found');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  AppUser _userFromFirebase(User user) {
    return AppUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName ?? '',
        birthDate: '',
        address: '');
  }

  Future<void> updateUserProfile(AppUser user) async {
    await _db.collection('users').doc(user.uid).update({
      'displayName': user.displayName,
      'birthDate': user.birthDate,
      'address': user.address,
    });
  }
}
