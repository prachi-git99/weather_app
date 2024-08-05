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
        return windows;
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
    apiKey: 'AIzaSyBJQHr1of4n3K6-QwTsiXEu--vPeFajb3U',
    appId: '1:268646327792:web:4ef933d387897ac5ff6935',
    messagingSenderId: '268646327792',
    projectId: 'weather-app-e3e65',
    authDomain: 'weather-app-e3e65.firebaseapp.com',
    storageBucket: 'weather-app-e3e65.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQaHCqK5YvWP_g1qfGIeF83413rzjb-aI',
    appId: '1:268646327792:android:d4f008cddf0cdaf8ff6935',
    messagingSenderId: '268646327792',
    projectId: 'weather-app-e3e65',
    storageBucket: 'weather-app-e3e65.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2J15n3eOMQs04E7mCYflZA5qN-dX29HA',
    appId: '1:268646327792:ios:38dada5ca4394558ff6935',
    messagingSenderId: '268646327792',
    projectId: 'weather-app-e3e65',
    storageBucket: 'weather-app-e3e65.appspot.com',
    iosBundleId: 'com.example.myWeatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2J15n3eOMQs04E7mCYflZA5qN-dX29HA',
    appId: '1:268646327792:ios:38dada5ca4394558ff6935',
    messagingSenderId: '268646327792',
    projectId: 'weather-app-e3e65',
    storageBucket: 'weather-app-e3e65.appspot.com',
    iosBundleId: 'com.example.myWeatherApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBJQHr1of4n3K6-QwTsiXEu--vPeFajb3U',
    appId: '1:268646327792:web:ad1489f827a9dda4ff6935',
    messagingSenderId: '268646327792',
    projectId: 'weather-app-e3e65',
    authDomain: 'weather-app-e3e65.firebaseapp.com',
    storageBucket: 'weather-app-e3e65.appspot.com',
  );
}