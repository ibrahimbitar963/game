import 'package:flutter/material.dart';
import 'package:game/HomeScreen.dart';

void main() {
  runApp(Game());
}
class Game extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomeScreen()
);
  }
}



