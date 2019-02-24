import 'dart:io';

import 'package:aurantic/app/report_page/image_carousel.dart';
import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _licenseController =TextEditingController();
  final TextEditingController _messageController =TextEditingController();

  @override
  void initState(){
    sl.get<ReportManager>().getNotifyReasons.execute();
    super.initState();  
  }
  Widget _licensePlate(){
      return TextField(
                controller: _licenseController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'License plate',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: sl.get<ReportManager>().textChangedCommand,
                  ),
                ),
              );
  }

  Widget _message(){
    return TextField(
      controller: _messageController,
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Message',
      ),
    );
  }

  Widget _notifyReason(){
    return Expanded(child: StreamBuilder(
      stream: sl.get<ReportManager>().getNotifyReasons,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return DropdownButton(
            items: snapshot.data.map((item) => DropdownMenuItem(value: item, child: Text(item),)).toList(),
            onChanged: (String value) {},
            isExpanded: true,
            );
        }
        else return DropdownButton(items: <DropdownMenuItem>[], onChanged: (value) {}, isExpanded: true,);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _licensePlate(),
              ImageCarousel(),
              _notifyReason(),
              _message()
            ],
          ),
        ),
    );
  }
}