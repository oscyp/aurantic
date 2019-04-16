import 'package:aurantic/domain_model/car_report_detail.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/widgets/car_report_tile.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class CarPage extends StatefulWidget {
  final String licensePlate;
  CarPage(this.licensePlate);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  void initState() {
    sl
        .get<AppManager>()
        .getReportsForLicenseCommand
        .execute(widget.licensePlate);
    super.initState();
  }

  Widget buildRow(BuildContext context, int index, List<CarReportDetail> list) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: CARD_COLOR,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new CarReportTile(carReport: list[index]),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(widget.licensePlate),
      ),
      body: Container(
          child: RxLoader<List<CarReportDetail>>(
        radius: 25.0,
        commandResults:
            sl.get<AppManager>().getReportsForLicenseCommand.results,
        dataBuilder: (context, data) {
          return ListView.builder(
            // itemExtent: 250.0,
            itemCount: data.length,
            itemBuilder: (context, index) => buildRow(context, index, data),
          );
        },
        placeHolderBuilder: (context) => Center(child: Text('no data')),
        errorBuilder: (context, ex) => Center(
              child: Text('Error: ${ex.toString()}'),
            ),
      )),
    );
  }
}

