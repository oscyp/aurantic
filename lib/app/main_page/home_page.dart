import 'package:aurantic/app/profile_page/profile_page.dart';
import 'package:aurantic/app/report_page/report_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState
    extends State<HomePage> /*with SingleTickerProviderStateMixin*/ {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  final _widgetOptions = [
    ProfilePage(),
    ProfilePage(),
    ReportPage(),
    ProfilePage()
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
        ));
  }
}
