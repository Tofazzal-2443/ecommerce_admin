
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCneuR2xnr-Eg7ZCkaHQf1bZSiy6JsMnrc',
    appId: '1:69220973237:android:140e39d9570830968d9cfc',
    messagingSenderId: '69220973237',
    projectId: 'ecommerce-e978e',
    storageBucket: 'ecommerce-e978e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9QYbhdjc6GK45A1q3ybh_CyVQycMCU4c',
    appId: '1:69220973237:ios:1923a20f607b41cd8d9cfc',
    messagingSenderId: '69220973237',
    projectId: 'ecommerce-e978e',
    storageBucket: 'ecommerce-e978e.appspot.com',
    iosClientId: '69220973237-6u6vjhfnfm38k4bfmr4mk84hham922nf.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceAdmin',
  );
}
