import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';

class AppUser with ChangeNotifier {
  //String username;
  String email;
  String id;
  FirebaseUser fbUser;

  void reset() {
    email = null;
    id = null;
    fbUser = null;
  }

  Future _registerUser(data, analysen, userTags) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.name, password: data.password)
        .then((user) async {
      analysen.loadWithId(user.user.uid, true);
      userTags.init(user.user.uid);
      email = user.user.email;
      id = user.user.uid;
      return "success";
    }).catchError((error) => error.code);
  }

  Future<String> register(LoginData data, analysen, userTags) async {
    var code = await _registerUser(data, analysen, userTags);
    print(code);
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "Email schon vergeben";
      case "ERROR_INVALID_EMAIL":
        return "Ungültige Email";
      case "ERROR_WEAK_PASSWORD":
        return "Passwort sollte min. 6 Zeichen haben";
      case "success":
        return null;
      default:
        print(code);
        return "Falsche Eingaben";
    }
  }

  Future<String> recoverPassword(String name) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: name).then((_) {
      return null;
    }).catchError((error) => error.code);
  }

  Future<String> login(LoginData data, analysen, userTags) async {
    var code = await Future.any(
      [
        _loginUser(data, analysen, userTags),
        Future.delayed(
          const Duration(seconds: 8),
        ),
      ],
    );
    switch (code) {
      case "ERROR_INVALID_EMAIL":
        return "Ungültige Email";
      case "ERROR_USER_NOT_FOUND":
        return "User existiert nicht";
      case "ERROR_WRONG_PASSWORD":
        return "Überprüfe dein Passwort";
      case "success":
        return null;
      default:
        print(code);
        return "Ungültige Eingaben";
    }
  }

  Future<String> _loginUser(data, analysen, userTags) async {
    //TODO if user not in database -> create him
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((user) async {
      print("manuelles login load with id");
      analysen.loadWithId(user.user.uid, false);
      userTags.loadTags(user.user.uid);
      email = user.user.email;
      id = user.user.uid;
      return "success";
    }).catchError((error) => error.code);
  }
}
