import 'package:flutter/material.dart';
import 'package:wallpaperpileapp/views/home.dart';

void main() {
  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50:   Color(0xFFFFFFFF),
      100:  Color(0xFFFFFFFF),
      200:  Color(0xFFFFFFFF),
      300:  Color(0xFFFFFFFF),
      400:  Color(0xFFFFFFFF),
      500:  Color(0xFFFFFFFF),
      600:  Color(0xFFFFFFFF),
      700:  Color(0xFFFFFFFF),
      800:  Color(0xFFFFFFFF),
      900:  Color(0xFFFFFFFF),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WallpaperPile',
      theme: ThemeData(
        primarySwatch: white,
      ),

      home: const Home(),
    );


  }
}
