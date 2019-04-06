import 'package:aurantic/app/report_detail_page/report_detail_page.dart';
import 'package:aurantic/app/report_page/image_carousel.dart';
import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/service_locator.dart';
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

  Duration whenNotified(DateTime date) {
    var now = DateTime.now();
    return now.difference(date);
  }

  Widget reasonTile(DateTime date) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          Text(
            "Adam Nawałka - ${whenNotified(date).inMinutes} mins ago",
            style: TextStyle(color: Colors.grey, fontSize: 13.0),
          ),
          iconsBar()
        ],
      ),
      children: <Widget>[
        ImageCarousel(),
        Text('t2'),
        Text('t3'),
      ],

      // subtitle: Text('todo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),),
      // // trailing: chooseIcon(list[index].notifications),
      // onTap: ()  {
      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new ReportDetailPage(4)));
      // },
    );
  }

  Widget messageBar(Report report) {
    return Padding(
        padding: EdgeInsets.only(left: 17),
        child: Row(
          children: <Widget>[
            iconsBar(),
            Text(
              report.message,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ));
  }

  Widget iconsBar() {
    return Row(children: <Widget>[
      Icon(Icons.looks_two),
      Icon(Icons.photo_camera),
      Icon(Icons.location_on)
    ]);
  }

  Widget buildRow(BuildContext context, int index, List<Report> list) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        color: CARD_COLOR,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              reasonTile(list[index].date),
              // messageBar(list[index]),
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
          child: RxLoader<List<Report>>(
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
