import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/user.dart';
import 'screens/analyse_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'models/analysen.dart';
import 'models/user_tags.dart';

import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;
void main() {
 /* initializeApp(
      apiKey: "AIzaSyBGzeNqKSgLXQtmvX1AO7SVkSwVQ2WRVCw",
      authDomain: "sk-log.firebaseapp.com",
      databaseURL: "https://sk-log.firebaseio.com",
      projectId: "sk-log",
      storageBucket: "sk-log.appspot.com",
      messagingSenderId: "1038850440158",
      appId: "1:1038850440158:web:ec7ff3e3d18bf72661fb4f");
*/
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  AppUser user = AppUser();
  FirebaseUser fbUser;

  @override
  void initState() {
   /* getUser().then((fbuser) {
      if (fbuser != null) {
        print("fbuser not null");
        user.email = fbuser.email;
        user.id = fbuser.uid;
        /* Firestore.instance.collection("User_Data").document(fbUser.uid).get().then((snap){
          user.username = snap.data["username"];
        });*/
      }
    }); */
    super.initState();
  }

  Future<FirebaseUser> getUser() async {
    return await auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Analysen(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserTags(), //TODO übergeben von firebase user id
        ),
        ChangeNotifierProvider(
          create: (ctx) => AppUser(),
        ),
      ],
      child: MaterialApp(
        title: 'SK Log',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.cyan,
          fontFamily: "OpenSans",
        ),
        home: HomeScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AnalyseScreen.routeName: (ctx) => AnalyseScreen(),
        },
      ),
    );
  }
}
