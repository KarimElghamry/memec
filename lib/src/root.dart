import 'package:flutter/material.dart';
import 'package:memec/src/ui/home/home_screen.dart';

class Memec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
