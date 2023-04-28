import 'package:api_app/screens/api_data.dart';
import 'package:api_app/screens/company.dart';
import 'package:api_app/screens/login_screen.dart';
import 'package:api_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getBool("isLogin");

  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => email == null || false ? LoginScreen() : ApiDataScreen(),
      '/movielist':(context)=>ApiDataScreen(),
      '/login':(context)=>LoginScreen(),
      '/signup':(context)=>SignUpScreen(),
      '/company-detail':(context)=>CompanyDetails(),
    },
  ));
}
