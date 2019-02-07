import 'package:aurantic/models/car.dart';
import 'package:aurantic/screens/observed/car_screen.dart';
import 'package:flutter/material.dart';

class CarTile extends StatelessWidget {
  final Car car;

  const CarTile({this.car});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('${car.licensePlate}'),
        subtitle: Text('${car.mark}, ${car.model}'),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CarScreen(car: car)));
        });
  }
}
