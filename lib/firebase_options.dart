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
    apiKey: 'AIzaSyCPCFkswp3nW3Y_rrk4-sGncqHUi6ciqF4',
    appId: '1:178617000944:web:7f3de05a8f0c63f835b335',
    messagingSenderId: '178617000944',
    projectId: 'daily-journal-feeb9',
    authDomain: 'daily-journal-feeb9.firebaseapp.com',
    storageBucket: 'daily-journal-feeb9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnCSM4jylVsHec4Xfz6fUp22WqloEuys4',
    appId: '1:178617000944:android:de144b519506a6e735b335',
    messagingSenderId: '178617000944',
    projectId: 'daily-journal-feeb9',
    storageBucket: 'daily-journal-feeb9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnPWIETPSj6freJkIvuFXsgFakNt7FktI',
    appId: '1:178617000944:ios:28dc7dd540650b4135b335',
    messagingSenderId: '178617000944',
    projectId: 'daily-journal-feeb9',
    storageBucket: 'daily-journal-feeb9.appspot.com',
    iosBundleId: 'com.example.dailyJurnal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnPWIETPSj6freJkIvuFXsgFakNt7FktI',
    appId: '1:178617000944:ios:16cab6ce4512b60435b335',
    messagingSenderId: '178617000944',
    projectId: 'daily-journal-feeb9',
    storageBucket: 'daily-journal-feeb9.appspot.com',
    iosBundleId: 'com.example.dailyJurnal.RunnerTests',
  );
}