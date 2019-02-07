import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/models/message.dart';
import 'package:flutter/material.dart';

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
              children: <Widget>[_licensePlate(), Divider(), _message(), _saveButton()],
            ),
          ),
        ));
  }
}
