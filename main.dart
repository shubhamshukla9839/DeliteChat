// ignore_for_file: prefer_const_constructors, deprecated_member_us

import 'package:first_app/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import './Screens/Homescreen.dart';

/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}
*/
void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF128C7E),
        //backgroundColor: Color(0xFF075E54),
      ),
      home: loginScreen(),
    );
  }
}
