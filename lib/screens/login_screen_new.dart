import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_tags.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home_screen.dart';
import '../models/analysen.dart';
import '../widgets/LoginScreenWidgets/logo.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:math';

class LoginScreenNew extends StatefulWidget{
  static const routeName = "/login_new";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginScreenNew> {
  var fbUser;
  var init = true;

  Future<String> _login(LoginData data) async {
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
        print(code);
        return "Invalid Inputs";
    }
  }

  Future<String> _loginUser(data) async {

    //TODO if user not in database -> create him
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: data.name, password: data.password)
        .then((user) async {
      Provider.of<Analysen>(context,listen: false).loadWithId(user.user.uid,false);
      Provider.of<UserTags>(context,listen: false).loadTags(user.user.uid);
      Provider.of<AppUser>(context,listen: false).email=user.user.email;
      Provider.of<AppUser>(context,listen: false).id=user.user.uid;
      return "success";
    }).catchError((error) => error.code);
  }

  Future _registerUser(data) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: data.name, password: data.password)
        .then((user) async {
      Provider.of<Analysen>(context,listen: false).loadWithId(user.user.uid,true);
      Provider.of<UserTags>(context,listen: false).init(user.user.uid);
      Provider.of<AppUser>(context,listen: false).email=user.user.email;
      Provider.of<AppUser>(context,listen: false).id=user.user.uid;
      return "success";
    }).catchError((error) => error.code);
  }

  Future<String> _register(LoginData data) async {
    var code = await _registerUser(data);
    print(code);
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
        print(code);
        return "Invalid Input";
    }
  }


  Future<String> _recoverPassword(String name) async {
    print('Name: $name');
    return FirebaseAuth.instance.sendPasswordResetEmail(email: name).then((_){
      return null;
    }).catchError((error) => error.code);


  }


  @override
  void initState() {
    super.initState();
    _auth.onAuthStateChanged.listen((data){
      if(data!=null){
        Provider.of<Analysen>(context).loadWithId(data.uid, false);
        Provider.of<UserTags>(context,listen: false).loadTags(data.uid);
        Provider.of<AppUser>(context,listen: false).email=data.email;
        Provider.of<AppUser>(context,listen: false).id=data.uid;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
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

  Widget buildLink(String description, Function onClick){
    return InkWell(
      onHover: (hover){}, //TODO mach variable für shadow hinter der ganzen row
      child: Row(
        children: <Widget>[
          Flexible(child: LayoutBuilder(builder:(ctx,constraints)=> Icon(MdiIcons.telegram,color: Colors.white,size: min(constraints.maxWidth,constraints.maxHeight),)),
          flex: 1,),
          Flexible(child: SizedBox(width: 20,)),
          Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: Container(

              child: AutoSizeText(
                description,
                style: TextStyle(
                  fontSize: 40,fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      onTap: (){
        onClick();
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        decoration: BoxDecoration(image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/bg-01.jpg")
        )),
        child: Row(children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 5,
            child: Container(
              padding: MediaQuery.of(context).size.width>1000?EdgeInsets.all(80):EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 // Expanded(child: Container(child: Logo(),),),
                  Flexible(child: Container(child:
                  Center(
                    child: AutoSizeText("Wilkommen zu SK!LOG \n",
                      //textAlign: TextAlign.right,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 42,fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                  ),
                  ),),
                  Flexible(flex: 2,
                    child: Container(child:
                  AutoSizeText(
                      "Dem Dokumentationstool für den Langfristigen Erfolg im Trading.",
                    //minFontSize: 20,

                    maxLines: 3,
                  style: TextStyle(
                  fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                  ),),
                 // SizedBox(height: 20,),
                  Flexible(child: Center(child: Logo(),),),

              SizedBox(height: 20,),
                  Flexible(
                    child: buildLink("Tritt der Community bei", (){_launchURL("https://t.me/SKTRoom");}),
                  ),
                  Flexible(
                    child: buildLink("Beantrage einen SK!Log Account", (){_launchURL("https://t.me/xlDownxl");}),
                  ),
                  Flexible(
                    child: buildLink("Technische Fragen", (){_launchURL("https://t.me/xlDownxl");}),
                  ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),),

          Flexible(
            fit: FlexFit.tight,
            flex: 6,
            child:FlutterLogin(   //TODO email und passwort validator in flutter_login wieder aktivieren
            //messages: LoginMessages(loginButton: "LEL"),
            title: '',
            //theme: LoginTheme(accentColor: Colors.transparent,pageColorLight: Colors.transparent),
            //logo: 'assets/SKLogo_Web.png',
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
          ),),
        ],
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );


    /*
    return FlutterLogin(   //TODO email und passwort validator in flutter_login wieder aktivieren
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
    );*/
  }
}
