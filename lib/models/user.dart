import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutterLogin/flutter_login.dart';
import '../models/user_tags.dart';
import 'user_pairs.dart';
import 'analysen.dart';

class AppUser with ChangeNotifier {
  String email;
  String id;
  FirebaseUser fbUser;
  bool isNew = false;

  void reset() {
    email = null;
    id = null;
    fbUser = null;
    isNew = false;
  }

  Future _registerUser(
    LoginData data,
    Analysen analysen,
    UserTags userTags,
  ) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.name, password: data.password)
        .then((user) {
      return userTags.init(user.user.uid).catchError((_) {
        print("User tag init failed, no error handling yet");
      }).then((_) {
        email = user.user.email;
        id = user.user.uid;
        isNew = true;
        return "success";
      });

    }).catchError((error) => error.code);
  }

  Future<String> register(
      LoginData data, Analysen analysen, UserTags userTags) async {
    var code = await _registerUser(data, analysen, userTags);
    switch (code) {
      case "auth/email-already-in-use":
        return "Diese Email ist schon vergeben";
      case "auth/invalid-email":
        return "Ungültige Email";
      case "auth/weak-password":
        return "Passwort sollte mindestens 6 Zeichen haben";
      case "auth/accountexistsalready": //TODO
        return "Passwort sollte mindestens 6 Zeichen haben";
      case "permission-denied":
        return "Bitte kontaktiere einen Admin";
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

  Future<String> login(
      LoginData data, Analysen analysen, UserTags userTags) async {
    String code = await _loginUser(data, analysen, userTags);

    switch (code) {
      case "auth/user-not-found":
        return "Benutzer existiert nicht";
      case "auth/wrong-password":
        return "Überprüfe dein Passwort";
      case "permission-denied":
        return "Bitte kontaktiere einen Admin";
      case "success":
        return null;
      default:
        return "Ungültige Eingaben";
    }
  }

  Future<String> _loginUser(
      LoginData data, Analysen analysen, UserTags userTags) {
    //TODO if user not in database -> create him
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((user) async {
      Future loadAnalysenFuture = analysen.loadWithId(user.user.uid, false);
      Future loadTagsFuture = userTags.loadTags(user.user.uid);

      email = user.user.email;
      id = user.user.uid;

      return Future.wait([loadAnalysenFuture, loadTagsFuture]);
    }).then((value) {
      return "success";
    }).catchError((error) {
      FirebaseAuth.instance.signOut();
      return error.code;
    });
  }
}
