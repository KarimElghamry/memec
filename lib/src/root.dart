import 'package:flutter/material.dart';
import 'package:memec/src/blocs/global.dart';
import 'package:memec/src/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

class Memec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (BuildContext context) => GlobalBloc(),
      dispose: (BuildContext context, GlobalBloc value) => value.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
