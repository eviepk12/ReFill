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
    apiKey: 'AIzaSyBsi-YEqkn7wEpiJkdStk5EHG_FlXI2wgg',
    appId: '1:775253888429:web:7ecedb985bdbd50d832524',
    messagingSenderId: '775253888429',
    projectId: 'refill-6ad86',
    authDomain: 'refill-6ad86.firebaseapp.com',
    storageBucket: 'refill-6ad86.appspot.com',
    measurementId: 'G-CYS8G2LZQG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBI5RZXV031T8lZZ3MCrvsiYd4I6f9MCks',
    appId: '1:775253888429:android:8cba1883732f17e0832524',
    messagingSenderId: '775253888429',
    projectId: 'refill-6ad86',
    storageBucket: 'refill-6ad86.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUqeWDo5uSOlRsG9UTXDSSzrRDPxADy8E',
    appId: '1:775253888429:ios:330ef5e92841110a832524',
    messagingSenderId: '775253888429',
    projectId: 'refill-6ad86',
    storageBucket: 'refill-6ad86.appspot.com',
    iosBundleId: 'com.example.refillApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUqeWDo5uSOlRsG9UTXDSSzrRDPxADy8E',
    appId: '1:775253888429:ios:e67f847bb78f42a7832524',
    messagingSenderId: '775253888429',
    projectId: 'refill-6ad86',
    storageBucket: 'refill-6ad86.appspot.com',
    iosBundleId: 'com.example.refillApp.RunnerTests',
  );
}
