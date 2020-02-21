import 'package:bomburger_pos/route.dart';
import 'package:flutter/material.dart';
import 'package:bomburger_pos/config/app_config.dart' as config;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Flutter UI',
      initialRoute: '/',
      onGenerateRoute: MyRoute.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        accentColor: config.CustomColors().mainDarkColor(1),
        hintColor: config.CustomColors().secondDarkColor(1),
        focusColor: config.CustomColors().accentDarkColor(1),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 20.0, color: config.CustomColors().secondDarkColor(1)),
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.CustomColors().secondDarkColor(1)),
          display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.CustomColors().secondDarkColor(1)),
          display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.CustomColors().mainDarkColor(1)),
          display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.CustomColors().secondDarkColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.CustomColors().secondDarkColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.CustomColors().mainDarkColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.CustomColors().secondDarkColor(1)),
          body2: TextStyle(fontSize: 14.0, color: config.CustomColors().secondDarkColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.CustomColors().secondDarkColor(0.6)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.CustomColors().mainColor(1),
        focusColor: config.CustomColors().accentColor(1),
        hintColor: config.CustomColors().secondColor(1),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 20.0, color: config.CustomColors().secondColor(1)),
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.CustomColors().secondColor(1)),
          display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.CustomColors().secondColor(1)),
          display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.CustomColors().mainColor(1)),
          display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.CustomColors().secondColor(1)),
          subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.CustomColors().secondColor(1)),
          title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.CustomColors().mainColor(1)),
          body1: TextStyle(fontSize: 12.0, color: config.CustomColors().secondColor(1)),
          body2: TextStyle(fontSize: 14.0, color: config.CustomColors().secondColor(1)),
          caption: TextStyle(fontSize: 12.0, color: config.CustomColors().accentColor(1)),
        ),
      ),
    );
  }
}
