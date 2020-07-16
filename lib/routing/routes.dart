/*
 * fluro
 * Created by Yakka
 * https://theyakka.com
 * 
 * Copyright (c) 2019 Yakka, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';
import '../screens/login_screen.dart';
import '../screens/analyse_screen.dart';
import '../screens/home_screen.dart';
class Routes {
  static String login = LoginScreen.routeName;
  static String home = HomeScreen.routeName;
  static String analyse_id = AnalyseScreen.routeName+"/:id";
  static String new_analyse = AnalyseScreen.routeName;

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      // ignore: missing_return
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
    router.define(analyse_id, handler: analyseHandler);
    router.define(new_analyse, handler: newAnalyseHandler);

  }
}
