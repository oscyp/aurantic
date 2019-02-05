import 'dart:convert';

import 'package:aurantic/auth.dart';
import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/models/car.dart';
import 'package:aurantic/screens/about_screen.dart';
import 'package:aurantic/screens/observed/car_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aurantic/helpers/constants.dart' as constants;

class HomeScreen extends StatefulWidget {
  IAuth auth;
  VoidCallback onSignedOut;

  HomeScreen({Key key, this.auth, this.onSignedOut}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Car> cars = new List<Car>();
  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Widget _buildDrawer() {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('name'),
          accountEmail: Text('email'),
          currentAccountPicture: Text('picture'),
        ),
        new ListTile(
          title: Text('Obserwowane'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new CarListScreen()));
          },
        ),
        new Divider(),
        new ListTile(
          title: Text('Settings'),
        ),
        new ListTile(
          title: Text('Feedback'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new AboutScreen()));
          },
        ),
        new ListTile(
          title: Text('Help'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new AboutScreen()));
          },
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home page'),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: _signOut)
        ],
      ),
      drawer: _buildDrawer(),
      body: Container(
        child: Text('home sc'),
      ),
    );
  }
}
