// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC451KCcvwdbfzmf3yDQMRknC9MrShgMDo',
    appId: '1:569640058105:web:ae40c5cad2c1e99bddf628',
    messagingSenderId: '569640058105',
    projectId: 'mojadiapp',
    authDomain: 'mojadiapp.firebaseapp.com',
    storageBucket: 'mojadiapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYuE6D8KCC5wgWvfh2whuxJfySJ04pSdA',
    appId: '1:569640058105:android:4b792624f4a528a8ddf628',
    messagingSenderId: '569640058105',
    projectId: 'mojadiapp',
    storageBucket: 'mojadiapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD26dB656Cyf5FCvwmTRjIOTbIS9d8wb1M',
    appId: '1:569640058105:ios:66f4b5815647042dddf628',
    messagingSenderId: '569640058105',
    projectId: 'mojadiapp',
    storageBucket: 'mojadiapp.appspot.com',
    iosBundleId: 'com.example.mojadiapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD26dB656Cyf5FCvwmTRjIOTbIS9d8wb1M',
    appId: '1:569640058105:ios:66f4b5815647042dddf628',
    messagingSenderId: '569640058105',
    projectId: 'mojadiapp',
    storageBucket: 'mojadiapp.appspot.com',
    iosBundleId: 'com.example.mojadiapp',
  );

}