import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> /*with SingleTickerProviderStateMixin*/ {
  final scaffoldKey =GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  final _widgetOptions = [
   ReportPage();
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
         items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('Observed')),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text('Lista')),
            BottomNavigationBarItem(
                icon: Icon(Icons.report), title: Text('Report')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile')),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
      )
    );
  }
}