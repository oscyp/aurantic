import 'package:aurantic/models/car.dart';
import 'package:flutter/material.dart';

class CarScreen extends StatelessWidget{
  final Car car;

  CarScreen({this.car});


  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 300,
        // height: 150,
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                ListTile(
                  title: Text('${car.licensePlate}'),
                  subtitle: Text('subtitle'),
                  leading: Text('leading'),
                  trailing: Text('trailing'),
                  onTap: () {
                    
                  },
                ),
                Divider(),
                Text("Marka: ", textAlign: TextAlign.left),
                Text("Model:")
              ],
            ),
        )
      );
  }

}