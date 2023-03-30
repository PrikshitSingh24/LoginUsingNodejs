import 'package:assignment/guest/guest.dart';
import 'package:assignment/home/home.dart';
import 'package:assignment/welcomScreen/page_2/page2.dart';
import 'package:assignment/welcomScreen/page_2/register.dart';
import 'package:assignment/welcomScreen/services/shared_services.dart';
import 'package:assignment/welcomScreen/welcomeScreen.dart';
import 'package:flutter/material.dart';

Widget _defaultHome=const welcomeScreen();

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome=const home();
  }
  runApp(MaterialApp(
    routes: {
      '/': (context) => _defaultHome,
      '/register': (context) => RegisterPage(),
      '/home': (context) => home(),
      '/page2': (context) => page2(),
      '/guest':(context)=>guest(),
    },
  ));
}