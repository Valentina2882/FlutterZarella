import 'package:flutter/material.dart';
import 'screens/home_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Network App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreens(),
      debugShowCheckedModeBanner: false, // Desactiva el banner de depuración
    );
  }
}
