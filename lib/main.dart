import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:flutter_food/pages/login/login_page.dart';
import 'package:flutter_food/pages/profile/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.prompt().fontFamily,
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 30.0),
          bodyText2: TextStyle(fontSize: 18.0),
        ),
      ),
      initialRoute: '/login',
      routes: {
        HomePage.routeName : (context) => HomePage(),
        LoginPage.routeName : (context) => LoginPage(),
        ProfilePage.routeName :(context) => ProfilePage(),
      },
    );
  }
}