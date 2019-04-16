import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/widgets/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ReportDetailPage extends StatefulWidget {
  final double reportId;

  const ReportDetailPage(this.reportId);
  @override
  _ReportDetailPageState createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  @override
  void initState() {
    sl.get<AppManager>().getReportCommand.execute(widget.reportId);

    super.initState();
  }

  Widget _map(LatLng position) {
    return Container(
      height: 180.0,
      child: GoogleMap(
          onMapCreated: (GoogleMapController mapController) {
            // _mapController = mapController;

            // _mapController.addMarker(
            //     MarkerOptions(position: markedPosition));
          },
          myLocationEnabled: false,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition:
              CameraPosition(target: position, zoom: DEFAULT_ZOOM)),
    );
  }

  Widget _message(String message) {
    return Container(
        // decoration: BoxDecoration(color: Colors.blueGrey),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Message',
          style: TextStyle(color: Colors.grey, fontSize: 15.0),
        ),
        Row(children: <Widget>[
          Text('\u25A0'),
          Text(
            message,
            style: TextStyle(fontSize: 20.0),
          )
        ])
      ],
    ));
  }

  Widget _photos() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Photos',
            style: TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
          ImageCarousel(false)
        ]);
  }

  Widget _author() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.red,
      ),
      title: Text('Adam Nawałka'),
      trailing: Text('Reports 9000'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Report')),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: RxLoader<Report>(
              radius: 25.0,
              commandResults: sl.get<AppManager>().getReportCommand.results,
              dataBuilder: (context, data) {
                return ListView(
                  children: <Widget>[
                    _author(),
                    _message(data.message),
                    _photos(),
                    _map(new LatLng(data.lat, data.long)),

                    //map, message, photos, author
                  ],
                );
              },
              placeHolderBuilder: (context) => Center(child: Text('no data')),
              errorBuilder: (context, ex) => Center(
                    child: Text('Error: ${ex.toString()}'),
                  ),
            )));
  }
}
