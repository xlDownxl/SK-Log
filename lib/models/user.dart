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
    FirebaseAuth.instance.signOut();
    email = null;
    id = null;
    fbUser = null;
    isNew = false;
  }
  
  Future<String> recoverPassword(String name) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: name).then((_) {
      return null;
    }).catchError((error) => error.code);
  }

  Future<String> handle_auth(
      LoginData data, Analysen analysen, UserTags userTags) async {
     var code = await _auth(data, analysen, userTags);
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
      case "auth/user-not-found":
        return "Benutzer existiert nicht";
      case "auth/wrong-password":
        return "Überprüfe dein Passwort";
      case "success":
        return null;
      default:
        return "Falsche Eingaben";
    }
  }

  Future _auth(
    LoginData data,
    Analysen analysen,
    UserTags userTags,
  ) {
    Future firebaseFuture;
    if (isNew) {
      firebaseFuture = FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: data.name, password: data.password);
    } else {
      firebaseFuture = FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.name, password: data.password);
    }
    return firebaseFuture.then((user) {
      Future userTagFuture;
      Future loadAnalysenFuture;
      if (isNew) {
        userTagFuture = userTags.init(user.user.uid);
        loadAnalysenFuture = analysen.loadWithId(user.user.uid, isNew);
      } else {
        userTagFuture = userTags.loadTags(user.user.uid);
        loadAnalysenFuture = analysen.loadWithId(user.user.uid, isNew);
      }
      return Future.wait([userTagFuture, loadAnalysenFuture]).then((_) {
        email = user.user.email;
        id = user.user.uid;
        return "success";
      }).catchError((error){
        print(error.code);
        return "Failed to read database";
      });
    }).catchError((error) => error.code);
  }
}
