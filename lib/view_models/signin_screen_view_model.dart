import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class SigninScreenViewModel {

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

  Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: ${e.code}");
      return false;
    } catch (e) {
      debugPrint("Non-FirebaseAuthException: ${e.toString()}");
      return false;
    }
  }
}