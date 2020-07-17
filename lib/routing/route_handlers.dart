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
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/analyse_screen.dart';
import 'package:provider/provider.dart';
import '../models/analysen.dart';

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  return LoginScreen();
});

var analyseHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  if(Provider.of<Analysen>(context).getAnalyse(params["id"][0])!=null) {
    return AnalyseScreen(params["id"][0]);
  }
  else{
    return HomeScreen();  //TODO maybe add a popup saying "does not exist"
  }

});
var newAnalyseHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return AnalyseScreen(null);
});