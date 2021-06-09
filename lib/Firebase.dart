import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseL {
  void signUpf(String email, String password) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInf(String email, String password) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }
}

void signout() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.signOut();
}

Future<String> getCurrentUser() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  try {
    final user = await firebaseAuth.currentUser;
    if (user != null) {
      return Future.value('content');
    } else {
      return Future.value('signup');
    }
  } catch (e) {
    print(e);
    return Future.value('null');
  }
}
