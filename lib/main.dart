import 'package:flutter/material.dart';
import 'package:stroi_komf/activities/home_screen.dart';
import 'package:stroi_komf/activities/main_screen.dart';


void main()  {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen());
  }
}
