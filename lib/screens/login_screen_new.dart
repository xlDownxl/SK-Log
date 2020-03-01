import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/user_tags.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home_screen.dart';
import '../models/analysen.dart';
import '../widgets/LoginScreenWidgets/logo.dart';

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
    return Future.delayed(Duration(seconds: 1)).then((_) {
      return "Not implemented yet";
    });
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        child: Row(children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Column(children: <Widget>[
            Expanded(child: Container(child: Logo(),),),
            Expanded(child: Container(child:
              Text("Welcome to SK!Log",style: TextStyle(
                fontSize: 30,fontWeight: FontWeight.bold,
              ),)
              ,),),
            Expanded(child: Container(child: Text("To request an account, just text us"),),),
            Expanded(child: Container(child: Text("Telegram: @xlDownxl"),),),
            Expanded(child: Container(child:
            InkWell(child:
            CircleAvatar(
              radius: 16,
              child: Image.asset("assets/telegram.png"),
            ),),
            ),),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          ),),

          Flexible(
            fit: FlexFit.tight,
            flex: 6,
            child:FlutterLogin(   //TODO email und passwort validator in flutter_login wieder aktivieren
            //messages: LoginMessages(loginButton: "LEL"),
            title: '',
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
