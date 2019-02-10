import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/models/message.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FaultReportScreen extends StatefulWidget {
  FaultReportScreen();
  @override
  State<StatefulWidget> createState() => _FaultReportScreenState();
}

class _FaultReportScreenState extends State<FaultReportScreen> {
  final formKey = new GlobalKey<FormState>();

  Message message = new Message();

  void initState() {
    // message.carId = widget.licensePlate;
  }

  void _takeByCamera(){

  }

  Widget _licensePlate(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'License plate',
        suffixIcon: IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: () => _takeByCamera
          )
      ),
      validator: (value) => value.isEmpty ? 'That field cannot be empty' : null,
      onSaved: (value) => message.licensePlate = value,
    );
  }

  Widget _photoCarousel(){
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black)
      ),
      child: Text('corousela todo'),
    );
  }

  Widget _reportType(){

  }

  Widget _location(){
    return Column(
      children: <Widget>[
        Container(
          // height: 150,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // width: 100,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {}, 
            initialCameraPosition: CameraPosition(
              target: LatLng(37.4219999, -122.0862462
              )
            ),
          ),
        )
      ]
    );
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
                _location(),
                // Divider(),
                _message(),
                _saveButton()
                ],
            ),
          ),
        ));
  }
}
