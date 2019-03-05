import 'dart:async';

import 'package:aurantic/app/report_page/image_carousel.dart';
import 'package:aurantic/app/report_page/map_location.dart';
import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final report = new Report();
  final List<DropdownMenuItem<String>> _drawbacks = [
    DropdownMenuItem(value: 'r1', child: Text('Reason1')),
    DropdownMenuItem(value: 'r2', child: Text('Reason2')),
    DropdownMenuItem(value: 'r3', child: Text('Reason3')),
    DropdownMenuItem(value: 'r4', child: Text('Reason4')),
    DropdownMenuItem(value: 'r5', child: Text('Reason5'))
  ];

  String selectedDrawback;
  LatLng markedPosition;
  StreamSubscription<List<String>> subscription;
  List<DropdownMenuItem> _notifyReasons = new List<DropdownMenuItem>();
  @override
  void initState() {
    subscription = sl.get<ReportManager>().getNotifyReasons.listen((result) {
      setState(() {
        _notifyReasons = result.map((x) => DropdownMenuItem(child: Text(x)));
      });
    });

    sl.get<ReportManager>().getNotifyReasons.execute();

    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Widget _licensePlate() {
    return TextFormField(
        controller: _licenseController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'License plate',
          suffixIcon: IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: sl.get<ReportManager>().textChangedCommand,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'That field cannot be empty' : null,
        onSaved: (value) => report.message = value);
  }

  Widget _message() {
    return TextFormField(
        controller: _messageController,
        maxLines: 5,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Message',
        ),
        validator: (value) =>
            value.isEmpty ? 'That field cannot be empty' : null,
        onSaved: (value) => report.message = value);
  }

  Widget _notifyReason() {
    return FormField<String>(
        builder: (state) {
          return DropdownButton<String>(
            items: _drawbacks,
            value: state.value,
            onChanged: (value) {
              state.didChange(value);
            },
            isExpanded: true,
          );
        },
        validator: (value) => (value == null || value.isEmpty)
            ? 'That field cannot be empty'
            : null,
        onSaved: (value) => report.reason = value);
  }

  Widget _locationLabel() {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
          onTap: () async {
            final LatLng result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new MapLocation()));

            setState(() {
              markedPosition = result;
            });
          },
          child: markedPosition == null
              ? Text('Tap to select location')
              : Text('Lat:${markedPosition.latitude}\n' +
                  'Long:${markedPosition.longitude}')),
    );
  }

  Widget _locationMap() {
    return Container(
      height: 180.0,
      child: GoogleMap(
          onMapCreated: (GoogleMapController mapController) {
            mapController.addMarker(
                MarkerOptions(position: mapController.cameraPosition.target));
          },
          myLocationEnabled: true,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition:
              CameraPosition(target: DEFAULT_POSITION, zoom: DEFAULT_ZOOM)),
    );
  }

  Widget _submitButton() {
    return MaterialButton(
      child: Text('Submit'),
      onPressed: () {
        if (_isFormValid()) {
          var report = new Report();
          sl.get<IApiService>().saveReport(report);
        }
      },
    );
  }

  bool _isFormValid() {
    final form = formKey.currentState;
    if (form.validate()) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _licensePlate(),
                // Spacer(),
                ImageCarousel(),
                _notifyReason(),
                _locationLabel(),
                _locationMap(),
                _message(),
                _submitButton()
              ],
            ),
          ),
        ));
  }
}
