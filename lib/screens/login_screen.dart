import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_tags.dart';
import '../flutterLogin/flutter_login.dart';
import 'home_screen.dart';
import '../models/analysen.dart';
import '../widgets/LoginScreenWidgets/logo.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

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
      //TODO show loading icon until this is loaded

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

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildLink(String description, Function onClick) {
    return InkWell(
      onHover: (hover) {}, //TODO mach variable für shadow hinter der ganzen row
      child: Row(
        children: <Widget>[
          Flexible(
            child: LayoutBuilder(
                builder: (ctx, constraints) => Icon(
                      MdiIcons.telegram,
                      color: Colors.white,
                      size: min(constraints.maxWidth, constraints.maxHeight),
                    )),
            flex: 1,
          ),
          Flexible(
              child: SizedBox(
            width: 20,
          )),
          Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: Container(
              child: AutoSizeText(
                description,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      onTap: () {
        onClick();
      },
    );
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
            : Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 5,
                    child: Container(
                      padding: MediaQuery.of(context).size.width > 1000
                          ? EdgeInsets.all(80)
                          : EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: Center(
                                child: AutoSizeText(
                                  "Wilkommen zu SK!LOG \n",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: AutoSizeText(
                                "Dem Dokumentationstool für den",
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: AutoSizeText(
                                "Langfristigen Erfolg im Trading.",
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(height: 20,),
                          Flexible(
                            flex: 2,
                            child: Center(
                              child: Logo(),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: buildLink("Tritt der Community bei", () {
                              _launchURL("https://t.me/SKTRoom");
                            }),
                          ),
                          Flexible(
                            child:
                                buildLink("Beantrage einen SK!Log Account", () {
                              _launchURL("https://t.me/xlDownxl");
                            }),
                          ),
                          Flexible(
                            child: buildLink("Technische Fragen", () {
                              _launchURL("https://t.me/xlDownxl");
                            }),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 6,
                    child: FlutterLogin(
                      //TODO email und passwort validator in flutter_login wieder aktivieren
                      title: '',
                      theme: LoginTheme(
                        accentColor: Colors.transparent,
                        pageColorLight: Colors.transparent,
                        pageColorDark: Colors.transparent,
                      ),
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
                ],
              ),
      ),
    );
  }
}
