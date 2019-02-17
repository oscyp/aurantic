import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/models/message.dart';
import 'package:aurantic/screens/fault_report_location_screen.dart';
import 'package:aurantic/screens/observed/create_car_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FaultReportScreen extends StatefulWidget {
  FaultReportScreen();
  @override
  State<StatefulWidget> createState() => _FaultReportScreenState();
}

class _FaultReportScreenState extends State<FaultReportScreen> {
  final formKey = new GlobalKey<FormState>();
  final List<DropdownMenuItem<String>> drawbacks = [
    DropdownMenuItem(value: 'dd', child: Text('dd1')),
    DropdownMenuItem(value: 'dd2', child: Text('dd2'))
  ];
  LatLng markedPostition;
  Message message = new Message();

  void initState() {
    // markedPostition = new LatLng(latitude, longitude)
    // message.carId = widget.licensePlate;
  }

  void _takeByCamera() {}

  Widget _licensePlate() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'License plate',
          suffixIcon: IconButton(
              icon: Icon(Icons.photo_camera), onPressed: () => _takeByCamera)),
      validator: (value) => value.isEmpty ? 'That field cannot be empty' : null,
      onSaved: (value) => message.licensePlate = value,
    );
  }

  Widget _photoCarousel() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      height: 60,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Text('corousela todo'),
    );
  }

  Widget _reportType() {}

  // Widget _locationLabel(){
  //   return  SizedBox(height: 50, width: 150, child: DropdownButton<String>(
  //     items: drawbacks,
  //     onChanged: (selected) => {},
  //     isExpanded: true
  //     )
  //   );
  // }

  Widget _locationLabel() {
    return SizedBox(
      height: 50,
      width: 150,
      child: GestureDetector(
          onTap: () async {
            final LatLng result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new FaultReportLocationScreen()));

            setState(() {
              markedPostition = result;
            });
          },
          child: markedPostition == null
              ? Text('not selected')
              : Text('Lat:${markedPostition.latitude}' +
                  'Long:${markedPostition.longitude}')),
    );
  }

  Widget _locationMap() {
    return Column(children: <Widget>[
      Container(
        height: 180,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            controller.addMarker(
                MarkerOptions(position: controller.cameraPosition.target));
          },
          myLocationEnabled: true,
          zoomGesturesEnabled: false,
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition:
              CameraPosition(target: DEFAULT_POSITION, zoom: DEFAULT_ZOOM),
        ),
      )
    ]);
  }

  Widget _message() {
    return TextFormField(
      maxLines: 7,
      keyboardType: TextInputType.multiline,
      autofocus: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hasFloatingPlaceholder: true,
          labelText: "Message"),
      validator: (value) => value.isEmpty ? 'That field cannot be empty' : null,
      onSaved: (value) => message.message = value,
    );
  }

  bool _validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      API.sendMessage(message);
    }
  }

  Widget _saveButton() {
    return MaterialButton(child: Text("Dodaj"), onPressed: _validateAndSubmit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            _licensePlate(),
            _photoCarousel(),
            // _reportType(),
            _locationLabel(),
            _locationMap(),
            // Divider(),
            _message(),
            _saveButton()
          ],
        ),
      ),
    ));
  }
}
