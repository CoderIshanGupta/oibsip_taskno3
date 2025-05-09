import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(CasioCalculatorApp());
}

class CasioCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casio fx-991ES Clone',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}