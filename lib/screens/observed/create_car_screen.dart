import 'dart:convert';

import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/models/car.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aurantic/helpers/constants.dart' as constants;

class CreateCarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CreateCarScreenState();
}

class _CreateCarScreenState extends State<CreateCarScreen> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldState = new GlobalKey<ScaffoldState>();
  Car car = new Car();

  Widget _registration() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hasFloatingPlaceholder: true,
        labelText: 'Numer rejestracyjny',
      ),
      validator: (value) =>
          value.isEmpty ? 'Numer rejestrcyjny nie może być pusty' : null,
      onSaved: (value) => car.licensePlate = value,
    );
  }

  Widget _mark() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hasFloatingPlaceholder: true,
        labelText: 'Marka',
      ),
      validator: (value) => value.isEmpty ? 'Marka nie może być pusta' : null,
      onSaved: (value) => car.mark = value,
    );
  }

  Widget _model() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hasFloatingPlaceholder: true,
        labelText: 'Model',
      ),
      validator: (value) => value.isEmpty ? 'Model nie może być pusty' : null,
      onSaved: (value) => car.model = value,
    );
  }

  Widget _color() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hasFloatingPlaceholder: true,
        labelText: 'Kolor',
      ),
      validator: (value) => value.isEmpty ? 'Kolor nie może być pusty' : null,
      onSaved: (value) => car.color = value,
    );
  }

  void _validateAndSubmit() {
    if (_validateAndSave()) {
      final future = API.registerCar(car);

      future.then((result) {
        if (result) {
          showSnackBarr("Udało się.");
        } else {
          showSnackBarr("błąd zapisu.");
        }
      });
    }
  }

  bool _validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void showSnackBarr(String text) {
    final snackBar = SnackBar(content: Text(text));
    scaffoldState.currentState.showSnackBar(snackBar);
  }

  Widget _addButton() {
    return MaterialButton(child: Text("Dodaj"), onPressed: _validateAndSubmit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text('Dodaj nowy'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              _registration(),
              Divider(),
              _mark(),
              Divider(),
              _model(),
              Divider(),
              _color(),
              _addButton()
            ],
          ),
        ),
      ),
    );
  }
}
