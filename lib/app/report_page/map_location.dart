import 'package:aurantic/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  LatLng markedPosition;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.onMarkerTapped.add(_onMarkerTapped);
  }

  void _onMarkerTapped(Marker marker) {
    debugPrint('dd');
  }

  void _add() {
    var latLng = LatLng(mapController.cameraPosition.target.latitude,
        mapController.cameraPosition.target.longitude);

    mapController.addMarker(MarkerOptions(position: latLng));

    setState(() {
      markedPosition = latLng;
    });
  }

  @override
  void dispose() {
    mapController?.onMarkerTapped?.remove(_onMarkerTapped);
    super.dispose();
  }

  Widget _mapArea() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 250,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          trackCameraPosition: true,
          initialCameraPosition:
              CameraPosition(target: DEFAULT_POSITION, zoom: DEFAULT_ZOOM),
        ));
  }

  Widget _acceptButton() {
    return MaterialButton(
      // height: 100,
      child: Text('Accept'),
      onPressed: () {
        if (markedPosition == null) {
          final snackBar = SnackBar(
            content: Text('You must provide a markup'),
            duration: Duration(seconds: 3),
          );

          scaffoldKey.currentState.showSnackBar(snackBar);
        } else {
          Navigator.pop(context, markedPosition);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('miejsce na search')),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Expanded(child: _mapArea()), _acceptButton()]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _add,
      ),
    );
  }
}
