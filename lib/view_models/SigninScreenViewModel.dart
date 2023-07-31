import 'package:firebase_auth/firebase_auth.dart';


class SigninScreenViewModel {

  SigninScreenViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user == null) {
        print('No User Signed In');
      } else {
        print('User is signed in: ${user.email}');
      }
    });
  }

  Future<String> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}