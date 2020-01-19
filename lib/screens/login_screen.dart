import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

import 'package:flutter_login/flutter_login.dart';
import 'home_screen.dart';


class LoginScreen extends StatefulWidget{
  static const routeName = "/login";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  var fbUser;
  var init = true;

  Future setupUserInFirebase(context) async {
   /* var user = await FirebaseAuth.instance.currentUser();
    Provider.of<User>(context, listen: false).email = user.email;
    Provider.of<User>(context, listen: false).id = user.uid;

    return Firestore.instance.collection("User_Data").document(user.uid).setData({
      "email": user.email,
      "id": user.uid,
    }).then((_){
      return Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(user.uid);
    });
    */
  }

  Future<String> _login(LoginData data) async {
    return null;
    var code = await Future.any(
      [
        _loginUser(data),
        Future.delayed(
          const Duration(seconds: 8),
        ),
      ],
    );
    switch (code) {
      case "ERROR_INVALID_EMAIL":
        return "Invalid Email";
      case "ERROR_USER_NOT_FOUND":
        return "User note found";
      case "ERROR_INVALID_EMAIL":
        return "Invalid Email";
      case "ERROR_WRONG_PASSWORD":
        return "Wrong Passord";
      case "success":
        return null;
      default:
        return "Invalid Inputs";
    }
  }

  Future<String> _loginUser(data) async {
    var userProvider = Provider.of<User>(context, listen: false);
    //TODO if user not in database -> create him
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((_) async {
     /* userProvider.getUserFromDB();

      await Provider.of<BoardPosts>(context, listen: false)
          .connectToFirebase(Provider.of<User>(context, listen: false).id);
*/
      return "success";
    }).catchError((error) => error.code);
    //});
  }

  Future<String> _register(LoginData data) async {
    return null;
    var code = await _registerUser(data);
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return "Email already taken";
      case "ERROR_INVALID_EMAIL":
        return "Invalid Email";
      case "ERROR_WEAK_PASSWORD":
        return "Password should be min. 6 Char.";
      case "success":
        return null;
      default:
        return "Invalid Input";
    }
  }

  Future<String> _registerUser(data) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: data.name, password: data.password)
        .then((_) async {
          /*
      //Provider.of<User>(context, listen: false).isNew = true;
      await setupUserInFirebase(context);
      */
      return "success";
    }).catchError((error) => error.code);
  }

  Future<String> _recoverPassword(String name) async {
    print('Name: $name');
    return Future.delayed(Duration(seconds: 1)).then((_) {
      return "Not implemented yet";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      //messages: LoginMessages(loginButton: "LEL"),
      title: 'SK!Log',
      //logo: 'assets/images/Download.jpeg',
      onLogin: _login,
      onSignup: _register,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
