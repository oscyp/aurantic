import 'dart:io';

import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<File> images = new List<File>();

  Widget _emptyImage(){
    return GestureDetector(
      onTap: sl.get<ReportManager>().getImageFromGallery,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black)
        ),
        child: Icon(Icons.add_a_photo),
      )
    );
  }

  Widget _pickedImage(){
    // return Image.file(sl.get<ReportManager>().getImage.res);
    return RxLoader<File>(
              radius: 25.0,
              commandResults: sl.get<ReportManager>().getImageFromGallery.results,
              dataBuilder: (context, data) =>Image.file(data),
              placeHolderBuilder: (context) => Center( child: Text("No Data")),
              errorBuilder: (context, ex) => Center(child: Text("Error: ${ex.toString()}")),
            );
  }
  
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        viewportFraction: 0.4,
        height: 250,
        items: <Widget>[
          _pickedImage(),
          _emptyImage()
        ],
      );
  }
}