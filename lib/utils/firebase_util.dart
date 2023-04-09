import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseUtil {
  connect() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyC3uRQeKJK7Hnr1zd1-dlZlGpNHBrWx0Vs',
          appId: '1:568095340416:web:9faa11a69c3a1f345bf365',
          messagingSenderId: '568095340416',
          projectId: 'todos-8388e',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  }
}
