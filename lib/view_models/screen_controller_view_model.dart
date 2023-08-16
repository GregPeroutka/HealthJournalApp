// Handles main initialization of the app - Connecting to DB, connecting to Account, etc
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../firebase_options.dart';


class ScreenControllerViewModel {


  static final ScreenControllerViewModel _instance = ScreenControllerViewModel._internal();
  factory ScreenControllerViewModel() {
    return _instance;
  }
  ScreenControllerViewModel._internal();

  StreamController<String> screenStreamController = StreamController<String>();
  
  Future<bool> initApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null) {
        debugPrint('User is NOT logged in');
        screenStreamController.sink.add('loginScreen');
      } else {
        debugPrint('User IS logged in');
        screenStreamController.sink.add('mainScreen');
      }
    });
    
    return true;
  }
}
