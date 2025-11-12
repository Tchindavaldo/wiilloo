// File generated from your existing GoogleService-Info.plist
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqUaNnWW0ERbES11TTVW2jzAgcTHFDhLc',
    appId: '1:66450079753:ios:1a34a756cf4aca117278d8',
    messagingSenderId: '66450079753',
    projectId: 'fir-d75bc',
    storageBucket: 'fir-d75bc.firebasestorage.app',
    iosBundleId: 'com.rudavo.wiilloo',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqUaNnWW0ERbES11TTVW2jzAgcTHFDhLc',
    appId: '1:66450079753:android:be60b1374be4f4fb7278d8',
    messagingSenderId: '66450079753',
    projectId: 'fir-d75bc',
    storageBucket: 'fir-d75bc.firebasestorage.app',
  );
}
