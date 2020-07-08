import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'models/user.dart';
import 'screens/analyse_screen.dart';
import 'package:provider/provider.dart';
import 'models/analysen.dart';
import 'models/user_tags.dart';
import 'screens/login_screen.dart';
import 'models/ascending.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: const Color(0xFF1E88E5),
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    errorColor: const Color(0xFFB00020),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base;
}

class _MyAppState extends State<MyApp> {
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
      ],
      child: MaterialApp(
        // onUnknownRoute: (settings) =>
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        title: 'SK!Log',
        theme: _buildLightTheme(),
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AnalyseScreen.routeName: (ctx) => AnalyseScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
