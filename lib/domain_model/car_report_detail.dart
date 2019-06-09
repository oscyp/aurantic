import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarReportDetail{
  String userName;
  DateTime notificationDate;
  String message;
  List<String> images;
  LatLng location;

  CarReportDetail.full(this.userName, this.notificationDate, this.message, this.images, this.location);
}