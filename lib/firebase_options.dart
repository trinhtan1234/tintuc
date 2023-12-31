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
    apiKey: 'AIzaSyCO52Vs-DDSFKiX_ichSPpES6ju_8DKXVg',
    appId: '1:516952873621:web:431737b0dbcd5064ab999c',
    messagingSenderId: '516952873621',
    projectId: 'apptintuc-db349',
    authDomain: 'apptintuc-db349.firebaseapp.com',
    storageBucket: 'apptintuc-db349.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAk5kDBTvjRVulgWeacZxl0w64Hrof7HrY',
    appId: '1:516952873621:android:723f11b63bfad897ab999c',
    messagingSenderId: '516952873621',
    projectId: 'apptintuc-db349',
    storageBucket: 'apptintuc-db349.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgTF_4karG3-FA-p7316XzfrFQcy4whd0',
    appId: '1:516952873621:ios:921008beb1919a34ab999c',
    messagingSenderId: '516952873621',
    projectId: 'apptintuc-db349',
    storageBucket: 'apptintuc-db349.appspot.com',
    iosClientId: '516952873621-h918dtd7igfl50bhgc7i7i97liilh06i.apps.googleusercontent.com',
    iosBundleId: 'com.example.tintuc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgTF_4karG3-FA-p7316XzfrFQcy4whd0',
    appId: '1:516952873621:ios:1c5722d0aa0107edab999c',
    messagingSenderId: '516952873621',
    projectId: 'apptintuc-db349',
    storageBucket: 'apptintuc-db349.appspot.com',
    iosClientId: '516952873621-f2bjcqcu196tt4jlh1vhcrgkidanan3a.apps.googleusercontent.com',
    iosBundleId: 'com.example.tintuc.RunnerTests',
  );
}
