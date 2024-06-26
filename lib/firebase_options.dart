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
    apiKey: 'AIzaSyDmpwYciadUAtjwyWc4gO1RrQTX8bqBw8g',
    appId: '1:562054259112:web:bf395a0aca3177e1eb3d9d',
    messagingSenderId: '562054259112',
    projectId: 'flutter-projects-a9f80',
    authDomain: 'flutter-projects-a9f80.firebaseapp.com',
    storageBucket: 'flutter-projects-a9f80.appspot.com',
    measurementId: 'G-K1B5T9T0HZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMZGzSp9qFajR9Mpc_n639OuD6l9BF5us',
    appId: '1:562054259112:android:358031b5f183baa6eb3d9d',
    messagingSenderId: '562054259112',
    projectId: 'flutter-projects-a9f80',
    storageBucket: 'flutter-projects-a9f80.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABaL0skY-jmIeWSgpZ66-1fwtdIj9g51c',
    appId: '1:562054259112:ios:58335fb0db406a7deb3d9d',
    messagingSenderId: '562054259112',
    projectId: 'flutter-projects-a9f80',
    storageBucket: 'flutter-projects-a9f80.appspot.com',
    iosBundleId: 'com.example.pushNotificationApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABaL0skY-jmIeWSgpZ66-1fwtdIj9g51c',
    appId: '1:562054259112:ios:6e65e50a45c93e8ceb3d9d',
    messagingSenderId: '562054259112',
    projectId: 'flutter-projects-a9f80',
    storageBucket: 'flutter-projects-a9f80.appspot.com',
    iosBundleId: 'com.example.pushNotificationApp.RunnerTests',
  );
}
