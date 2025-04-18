import 'package:flutter/material.dart';

class StagesScreen extends StatefulWidget {
  const StagesScreen({super.key});

  @override
  State <StagesScreen> createState() => _StagesScreenState();
}

class _StagesScreenState extends State<StagesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "StagesScreen!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}