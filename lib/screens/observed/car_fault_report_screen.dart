import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/models/message.dart';
import 'package:flutter/material.dart';

class CarFaultReportScreen extends StatefulWidget {

  final String licensePlate;
  CarFaultReportScreen(this.licensePlate);
  @override
  State<StatefulWidget> createState() => _CarFaultReportScreenState();
}

class _CarFaultReportScreenState extends State<CarFaultReportScreen> {
  final formKey = new GlobalKey<FormState>();
 
  Message message = new Message();

  void initState() {
    // message.carId = widget.licensePlate;
  }
  Widget _message(){
     return TextFormField(
         maxLines: 7,
         keyboardType: TextInputType.multiline,
         autofocus: true,
         decoration: InputDecoration(
           border: OutlineInputBorder(),
           hasFloatingPlaceholder: true,
           labelText: "Wiadomość"
         ),
         validator: (value) => value.isEmpty ? 'Nie może być pusty' : null,
         onSaved: (value) => message.message = value,
       );
  }

  bool _validateAndSave() {
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }

    return false;
  }

  void _validateAndSubmit(){
    if(_validateAndSave()){
      // message.carId = licensePlate;
      message.carId = 2;
      API.sendMessage(message);
    }
  }

  Widget _saveButton(){
    return MaterialButton(child: Text("Dodaj"), onPressed: _validateAndSubmit);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nowe zgłoszenie"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              _message(),
              _saveButton()
            ],
          ),
        ),
      )
    );
  }
}
