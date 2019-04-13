import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarReportDetail{
  String userName;
  DateTime notificationDate;
  String message;
  List<File> images;
  LatLng location;

  CarReportDetail.full(this.userName, this.notificationDate, this.message, this.images, this.location);
}