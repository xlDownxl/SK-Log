import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../flutterLogin/flutter_login.dart';
import '../models/user_tags.dart';
import 'user_pairs.dart';
import 'analysen.dart';

class AppUser with ChangeNotifier {
  //String username;
  String email;
  String id;
  FirebaseUser fbUser;
  bool isNew=false;

  void reset() {
    email = null;
    id = null;
    fbUser = null;
    isNew=false;
  }

  Future _registerUser(LoginData data, Analysen analysen, userTags,) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: data.name, password: data.password)
        .then((user) async {
      analysen.loadWithId(user.user.uid, true);
      userTags.init(user.user.uid);
      email = user.user.email;
      id = user.user.uid;
      isNew=true;
      return "success";
    }).catchError((error) => error.code);
  }

  Future<String> register( data, analysen, userTags) async {
    var code = await _registerUser(data, analysen, userTags);
    print(code);
    switch (code) {
      case "auth/email-already-in-use":
        return "Diese Email ist schon vergeben";
      case "auth/invalid-email":
        return "Ungültige Email";
      case "auth/weak-password":
        return "Passwort sollte mindestens 6 Zeichen haben";
      case "auth/accountexistsalready"://TODO
        return "Passwort sollte mindestens 6 Zeichen haben";
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

  Future<String> login(LoginData data, analysen, userTags,) async {
    var code = await Future.any(
      [
        _loginUser(data, analysen, userTags,),
        Future.delayed(
          const Duration(seconds: 8),
        ),
      ],
    );
    switch (code) {
      case "auth/user-not-found":
        return "Benutzer existiert nicht";
      case "auth/wrong-password":
        return "Überprüfe dein Passwort";
      case "success":
        return null;
      default:
        return "Ungültige Eingaben";
    }
  }

  Future<String> _loginUser(LoginData data,Analysen analysen, UserTags userTags) async {
    //TODO if user not in database -> create him
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((user) async {
      analysen.loadWithId(user.user.uid, false);
      userTags.loadTags(user.user.uid);
      email = user.user.email;
      id = user.user.uid;
      return "success";
    }).catchError((error) => error.code);
  }
}
