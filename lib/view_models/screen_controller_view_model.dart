import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import '../firebase_options.dart';

class ScreenControllerViewModel {

  static final StreamController<ScreenType> _screenStreamController = StreamController<ScreenType>();
  static final Stream<ScreenType> _screenBroadcastStream = _screenStreamController.stream.asBroadcastStream();
  static final StreamSink<ScreenType> _screenStreamSink = _screenStreamController.sink;

  static Stream<ScreenType> get screenBroadcastStream => _screenBroadcastStream;
  static StreamSink<ScreenType> get screenStreamSink => _screenStreamSink;
  
  static Future<bool> initApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null) {
        debugPrint('User is NOT logged in');
        _screenStreamSink.add(ScreenType.signin);
      } else {
        debugPrint('User IS logged in');
        _screenStreamSink.add(ScreenType.main);
      }
    });
    
    return true;
  }
}
