
import 'dart:async';

import 'package:aurantic/app/report_page/image_carousel.dart';
import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _licenseController =TextEditingController();
  final TextEditingController _messageController =TextEditingController();

  StreamSubscription<List<String>> subscription;


  @override
  void initState(){

    subscription = sl.get<ReportManager>()
    .getNotifyReasons
    .listen((result) => {});

    super.initState();  
  }

  @override
  void dispose(){
    subscription?.cancel();
    super.dispose();
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
    return Expanded(child: RxLoader<List<String>>(
      radius: 25.0,
      commandResults: sl.get<ReportManager>().getNotifyReasons.results,
      dataBuilder: (context, snapshot){
          return DropdownButton(
            items: snapshot.map((item) => DropdownMenuItem(value: item, child: Text(item),)).toList(),
            onChanged: (String value) {},
            isExpanded: true,
            );
        },
        placeHolderBuilder: (context) => DropdownButton(items: <DropdownMenuItem>[], onChanged: (value) {}, isExpanded: true,),
        errorBuilder: (context, ex)  { 
          print(ex); return Center(
        child: Text("Error: ${ex.toString()}"));},
      )
    );
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