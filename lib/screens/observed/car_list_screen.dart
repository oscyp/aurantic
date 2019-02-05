import 'dart:convert';

import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/models/car.dart';
import 'package:aurantic/screens/about_screen.dart';
import 'package:aurantic/screens/observed/create_car_screen.dart';
import 'package:aurantic/screens/observed/widgets/car_tile.dart';
import 'package:flutter/material.dart';

class CarListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  var cars = new List<Car>();
  var loaded = false;
  initState() {
    super.initState();
    _getCars();
  }

  _getCars() {
    try {
      API.getCars().then((response) {
        setState(() {
          Iterable list = json.decode(response.body);
          cars = new List<Car>();
          cars = list.map((x) => Car.fromJson(x)).toList();
          loaded = true;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obserwowane'),
      ),
      body: this.loaded
          ? _buildList(context)
          : Align(
              alignment: Alignment.center, child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add_circle),
        label: Text('Dodaj'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => new CreateCarScreen()));
        },
        isExtended: false,
      ),
    );
  }

  ListView _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, int) {
        return CarTile(car: cars[int]);
      },
    );
  }
}
