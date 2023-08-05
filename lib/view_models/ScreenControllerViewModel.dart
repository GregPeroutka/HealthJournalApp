// Handles main initialization of the app - Connecting to DB, connecting to Account, etc
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';


class PageControllerViewModel {

  Future<bool> initApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    return true;
  }
}
