import 'package:aurantic/domain_model/car_report_detail.dart';
import 'dart:convert';
import 'package:aurantic/widgets/image_carousel.dart';
import 'package:flutter/material.dart';

class CarReportTile extends StatelessWidget {
  const CarReportTile({
    Key key,
    @required this.carReport,
  }) : super(key: key);

  final CarReportDetail carReport;

  int getMinutesWhenReportWasCreated() {
    var now = DateTime.now();
    return now.difference(carReport.notificationDate).inMinutes;
  }

  Icon getPotoIconCountIfReported(){
    if (carReport.images != null){
      switch (carReport.images.length){
        case 1: return Icon(Icons.looks_one);
        case 2: return Icon(Icons.looks_two);
        case 3: return Icon(Icons.looks_3);
        case 4: return Icon(Icons.looks_4);
        case 5: return Icon(Icons.looks_5);
        case 6: return Icon(Icons.looks_6);
      }
    }
    return null;
  }

  Icon getPhotoIconIfReported(){
    return carReport.images != null ? Icon(Icons.photo_camera) : null;
  }

  Icon getLocationIconIfReported(){
    return carReport.location != null ? Icon(Icons.location_on) : null;
  }

  Icon getMessageIconIfReported(){
    return (carReport.message != null && carReport.message.isNotEmpty) ? Icon(Icons.message) : null;
  }
  
  Widget iconsBar() {
    return Row(children: <Widget>[
      getPotoIconCountIfReported(),
      getPhotoIconIfReported(),
      getLocationIconIfReported(),
      getMessageIconIfReported(),
    ].where((x) => x != null).toList());
  }

  Widget showImageCarouselIfImagesAttached(){
    return (carReport.images != null && carReport.images.length > 0) 
      ? ImageCarousel(false,
       images: carReport.images.map((x) => Image.memory(base64Decode(x))).toList()) 
      : null;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          Text(
            "${carReport.userName} - ${getMinutesWhenReportWasCreated()} mins ago",
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
          iconsBar()
        ],
      ),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
              Text(carReport.message, textAlign: TextAlign.start, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
              showImageCarouselIfImagesAttached(),
            ].where((x) => x != null).toList(),
          ),
        )
      ],
    );
  }
}
