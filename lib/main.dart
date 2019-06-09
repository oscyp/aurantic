import 'package:aurantic/app/main_page/home_page.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';

void main() {
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//todo: tocheck:
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: Colors.yellow
        // accentColor: CARD_COLOR
      ),
      home: HomePage(),
    );
  }
}
