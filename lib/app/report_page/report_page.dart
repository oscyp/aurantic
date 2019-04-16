import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aurantic/app/report_page/map_location.dart';
import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/widgets/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  GoogleMapController _mapController;
  StreamSubscription<bool> saveReportSubscription;
  StreamSubscription<File> subscription;
  List<File> fileImages = new List<File>();

  @override
  void initState() {
    markedPosition = DEFAULT_POSITION;

    saveReportSubscription =
        sl.get<ReportManager>().saveReport.listen((result) {
      setState(() {
        if (result) {
          formKey.currentState.reset();
          _licenseController.clear();
          _messageController.clear();
        }

        final snackBar = SnackBar(
          content: result ? Text('Reported') : Text('Something went wrong...'),
          duration: Duration(seconds: 3),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      });
    });

    subscription = sl.get<ReportManager>().getImageFromGallery.listen((file) async {
      if (file != null){
        setState(() {
          fileImages.add(file);
        });
      }
  });

    sl.get<ReportManager>().getNotifyReasons.execute();

    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    saveReportSubscription?.cancel();
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
            onPressed: sl<ReportManager>().textChangedCommand,
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'That field cannot be empty' : null,
        onSaved: (value) => report.licensePlate = value);
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
          return Column(children: <Widget>[
            InputDecorator(
                decoration:
                    const InputDecoration(contentPadding: EdgeInsets.all(0.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: _drawbacks,
                    value: state.value,
                    onChanged: (value) {
                      state.didChange(value);
                    },
                    isExpanded: true,
                  ),
                )),
            Text(state.hasError ? state.errorText : '',
                style: TextStyle(color: Colors.redAccent.shade700))
          ]);
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
              _mapController.clearMarkers();
              _mapController.addMarker(MarkerOptions(position: markedPosition));
              _mapController.moveCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: markedPosition, zoom: DEFAULT_ZOOM)));
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
            _mapController = mapController;

            _mapController.addMarker(MarkerOptions(position: markedPosition));
          },
          myLocationEnabled: false,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition:
              CameraPosition(target: markedPosition, zoom: DEFAULT_ZOOM)),
    );
  }

  Widget _submitButton() {
    return MaterialButton(
      child: Text('Submit'),
      onPressed: () {
        if (_isFormValid()) {
          
          report.date = DateTime.now();
          report.files = fileImages.map((x) {
          try{
            return base64Encode(x.readAsBytesSync());

          }
          catch(e){
            print(e);
          }}
          ).toList();
          sl.get<ReportManager>().saveReport(report);
        }
      },
    );
  }

  bool _isFormValid() {
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
       return true;}
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      // child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            _licensePlate(),
            const SizedBox(height: 7),
            ImageCarousel(true),
            // const SizedBox(height: 7),
            // _notifyReason(),
            // const SizedBox(height: 7),
            // _locationLabel(),
            // const SizedBox(height: 7),
            // _locationMap(),
            const SizedBox(height: 7),
            _message(),
            const SizedBox(height: 7),
            _submitButton()
          ],
        ),
      ),
      // )
    );
  }
}
