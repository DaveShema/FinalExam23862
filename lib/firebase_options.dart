// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBj4iUmirjT38dp2Rlg_QzwY_x5tySOEE8',
    appId: '1:330216719379:web:52c23215fd772f7c07ebe6',
    messagingSenderId: '330216719379',
    projectId: 'midproject-400d0',
    authDomain: 'midproject-400d0.firebaseapp.com',
    storageBucket: 'midproject-400d0.appspot.com',
    measurementId: 'G-VQYBMKNHR2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEj3jNZGFHIR5F1gdiWS02Y6YhVmMwUU0',
    appId: '1:330216719379:android:11730389e2b7c73607ebe6',
    messagingSenderId: '330216719379',
    projectId: 'midproject-400d0',
    storageBucket: 'midproject-400d0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSKjmdL10dGTPzlx4TlGzFcRvkcHRNDoY',
    appId: '1:330216719379:ios:1c96aff88184a81507ebe6',
    messagingSenderId: '330216719379',
    projectId: 'midproject-400d0',
    storageBucket: 'midproject-400d0.appspot.com',
    iosBundleId: 'com.example.calculatorapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBSKjmdL10dGTPzlx4TlGzFcRvkcHRNDoY',
    appId: '1:330216719379:ios:e7ac05f482a078f507ebe6',
    messagingSenderId: '330216719379',
    projectId: 'midproject-400d0',
    storageBucket: 'midproject-400d0.appspot.com',
    iosBundleId: 'com.example.calculatorapp.RunnerTests',
  );
}