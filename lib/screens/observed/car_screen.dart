import 'package:aurantic/models/car.dart';
import 'package:aurantic/screens/observed/fault_report_screen.dart';
import 'package:flutter/material.dart';

class CarScreen extends StatelessWidget {
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
            title: Text(
              '${car.licensePlate}',
              style: TextStyle(fontSize: 50.0),
            ),
            subtitle: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                  text: '${car.mark}',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              TextSpan(text: ', ${car.model}', style: TextStyle(fontSize: 20.0))
            ])),
            // trailing: Text('trailing'),
            onTap: () {},
          ),
          //Image
          Container(height: 180.0, color: Colors.red),
          Divider(),
          Text("Marka: ${car.mark}", textAlign: TextAlign.left),
          Text("Model: ${car.model}"),
          ButtonTheme.bar(
              child: ButtonBar(
            children: <Widget>[
              FlatButton(
                  child: const Text("Zgłoś usterkę"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FaultReportScreen()));
                  }),
              FlatButton(
                  child: const Text("Coś tam jeszcze"), onPressed: () => {})
            ],
          ))
        ],
      ),
    ));
  }
}
