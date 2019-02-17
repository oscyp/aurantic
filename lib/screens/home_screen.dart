import 'package:aurantic/auth.dart';
import 'package:aurantic/models/car.dart';
import 'package:aurantic/screens/observed/car_list_screen.dart';
import 'package:aurantic/screens/observed/fault_report_screen.dart';
import 'package:aurantic/screens/observed/observed_car_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  IAuth auth;
  VoidCallback onSignedOut;

  HomeScreen({Key key, this.auth, this.onSignedOut}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  final _widgetOptions = [
    ObservedCarListScreen(),
    CarListScreen(),
    FaultReportScreen(),
    UserAccountsDrawerHeader(
        accountName: Text('name'),
        accountEmail: Text('email'),
        currentAccountPicture: Text('picture'))
  ];
  List<Car> cars = new List<Car>();
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Home page'),
        //   actions: <Widget>[
        //     FlatButton(
        //         child: Text('Logout',
        //             style: TextStyle(fontSize: 17.0, color: Colors.white)),
        //         onPressed: _signOut)
        //   ],
        // ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
