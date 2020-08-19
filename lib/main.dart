import 'package:flutter/material.dart';
import 'package:flutter_app/models/analysen_filter.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';
import 'models/analysen.dart';
import 'models/user_tags.dart';
import 'models/helper_providers.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'routing/routes.dart';
import 'routing/application.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


const Color primaryColor = Color(0xFF0175c2);
const Color secondaryColor = Color(0xFF13B9FD);


class _MyAppState extends State<MyApp> {

  _MyAppState() {
    final router = fluro.Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Analysen(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserTags(), //TODO
        ),
        ChangeNotifierProvider(
          create: (ctx) => AppUser(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Ascending(false),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Animations(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AnalyseFilter(), //TODO <= brauch cih den überhaupt????
        ),
        ChangeNotifierProvider(
          create: (ctx) => FilterMode(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UsingScrollbar(),
        ),
      ],
      child: MaterialApp(
        title: 'SK!Log',
        theme: ThemeData(
          accentColorBrightness: Brightness.dark,
          primaryColor: primaryColor,
          buttonColor: primaryColor,
          accentColor: secondaryColor,
          canvasColor: Colors.white,
          fontFamily: "OpenSans",

          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
