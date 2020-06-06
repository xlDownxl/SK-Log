import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_tags.dart';
import '../flutterLogin/flutter_login.dart';
import 'home_screen.dart';
import '../models/analysen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login_new";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginScreen> {
  AppUser user;
  var init = true;
  var subscription;
  bool showLoadingIndicator = true;

  @override
  void initState() {
    super.initState();
    subscription = _auth.onAuthStateChanged.listen((data) {
      if (data != null) {
        Provider.of<Analysen>(context, listen: false)
            .loadWithId(data.uid, false);
        Provider.of<UserTags>(context, listen: false).loadTags(data.uid);
        Provider.of<AppUser>(context, listen: false).email = data.email;
        Provider.of<AppUser>(context, listen: false).id = data.uid;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
      } else {
        setState(() {
          showLoadingIndicator = false;
        });
        subscription.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/bg-01.jpg"))),
        child: showLoadingIndicator
            ? Center(child: CircularProgressIndicator())
            : FlutterLogin(
              title: '',
              messages: LoginMessages(
                  signupButton: "Registrieren",
                  forgotPasswordButton: "Passwort vergessen?",
                  passwordHint: "Passwort",
                  goBackButton: "Zurück",
                  recoverPasswordIntro:
                      "Setze dein Passwort hier zurück",
                  recoverPasswordDescription:
                      "Du erhälst eine Email zum zurücksetzen deines Passwortes.",
                  recoverPasswordButton: "Zurücksetzen",
                  confirmPasswordHint: "Passwort bestätigen"),
              onLogin: (data) {
                return user.login(
                    data,
                    Provider.of<Analysen>(context, listen: false),
                    Provider.of<UserTags>(context, listen: false));
              },
              onSignup: (data) {
                return user.register(
                    data,
                    Provider.of<Analysen>(context, listen: false),
                    Provider.of<UserTags>(context, listen: false));
              },
              onRecoverPassword: user.recoverPassword,
              onSubmitAnimationCompleted: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomeScreen(),
                  ),
                );
              },
            ),
      ),
    );
  }
}
