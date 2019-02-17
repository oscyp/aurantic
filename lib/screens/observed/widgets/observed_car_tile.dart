import 'package:aurantic/models/car.dart';
import 'package:aurantic/screens/observed/car_screen.dart';
import 'package:flutter/material.dart';

class ObservedCarTile extends StatelessWidget {
  final Car car;
  final notificationNumber = const [
    [0, null],
    [1, Icons.filter_1],
    [2, Icons.filter_2],
    [3, Icons.filter_3],
    [4, Icons.filter_4],
    [5, Icons.filter_5],
    [6, Icons.filter_6],
    [7, Icons.filter_7],
    [8, Icons.filter_8],
    [9, Icons.filter_9],
    [10, Icons.filter_9_plus]
  ];
  const ObservedCarTile({this.car});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('${car.licensePlate}'),
        subtitle: Text('${car.mark}, ${car.model}'),
        trailing: Column(children: <Widget>[
          IconButton(icon: Icon(Icons.filter_1)),
          IconButton(icon: Icon(Icons.delete))
        ]),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CarScreen(car: car)));
        });
  }
}
