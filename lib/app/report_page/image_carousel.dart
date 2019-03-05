import 'dart:async';
import 'dart:io';

import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<File> fileImages = new List<File>();

  StreamSubscription<File> subscription;
  @override
  void initState() {
    subscription = sl.get<ReportManager>().getImageFromGallery.listen((result) {
      setState(() {
        fileImages.add(result);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Widget _emptyImage() {
    return GestureDetector(
        onTap: sl.get<ReportManager>().getImageFromGallery,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              color: Colors.black12, border: Border.all(color: Colors.black)),
          child: Icon(Icons.add_a_photo),
        ));
  }

  List<Widget> _images() {
    var images = fileImages
        .map((img) => GestureDetector(child: Image.file(img)))
        .toList();
    images.add(_emptyImage());

    return images;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        viewportFraction: 0.55, height: 250, items: _images());
  }
}
