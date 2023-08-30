// Handles main initialization of the app - Connecting to DB, connecting to Account, etc
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import '../firebase_options.dart';


class ScreenControllerViewModel {


  static final ScreenControllerViewModel _instance = ScreenControllerViewModel._internal();
  factory ScreenControllerViewModel() {
    return _instance;
  }
  ScreenControllerViewModel._internal();

  StreamController<ScreenType> screenStreamController = StreamController<ScreenType>();
  
  Future<bool> initApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null) {
        debugPrint('User is NOT logged in');
        screenStreamController.sink.add(ScreenType.signin);
      } else {
        debugPrint('User IS logged in');
        screenStreamController.sink.add(ScreenType.main);
      }
    });
    
    return true;
  }
}
