import 'package:flutter/material.dart';
import 'package:stroi_komf/activities/home_screen.dart';
import 'package:stroi_komf/activities/calculator_screen.dart';
import 'package:stroi_komf/activities/stages_screen.dart';
import 'package:stroi_komf/activities/service_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Список страниц
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    CalculatorScreen(),
    StagesScreen(),
    ServiceScreen(),
  ];

  // Обработчик выбора элемента из BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.ac_unit),
              const SizedBox(width: 8,),
              const Text('Test App'),
            ]
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),


      body: _pages[_selectedIndex],   // Показываем экран в зависимости от выбранного индекса


      bottomNavigationBar: BottomNavigationBar(

          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Проекты'),
            BottomNavigationBarItem(
                icon: Icon(Icons.construction), label: 'Калькулятор'),
            BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Этапы'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: 'Обслуживание'),
          ]
      ),
    );
  }
}