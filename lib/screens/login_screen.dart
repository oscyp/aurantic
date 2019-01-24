import 'dart:io';

import 'package:aurantic/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum FormMode { SIGNIN, SINGUP }

class LoginScreen extends StatefulWidget {
  final IAuth auth;
  final VoidCallback onSignedIn;

  const LoginScreen({this.auth, this.onSignedIn});

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormMode _formMode = FormMode.SIGNIN;

  Widget _emailInput() {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          )),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      onSaved: (value) => _email = value,
    );
  }

  Widget _passwordInput() {
    return new TextFormField(
      obscureText: true,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Password', icon: new Icon(Icons.lock, color: Colors.grey)),
      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _label() {
    if (_formMode == FormMode.SIGNIN) {
      return new FlatButton(
        child: new Text('Create an account',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _signIn,
      );
    } else {
      return new FlatButton(
        child: new Text('Have an account? Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _signUp,
      );
    }
  }

  Widget _submitButton() {
    if (_formMode == FormMode.SIGNIN) {
      return new Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: new Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.blueAccent.shade100,
          elevation: 5.0,
          child: new MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            color: Colors.blue,
            child: new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ),
      );
    } else {
      return new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: new Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.lightBlueAccent.shade100,
              elevation: 5.0,
              child: new MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                color: Colors.blue,
                child: new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: validateAndSubmit,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login to Aurantic"),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _emailInput(),
              _passwordInput(),
              _submitButton(),
              _label()
            ],
          ),
        ),
      ),
    );
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formMode == FormMode.SIGNIN) {
          bool status = await widget.auth.signIn(_email, _password);
          print('SignedIN status: $status');
        } else {
          bool status = await widget.auth.signUp(_email, _password);
          print('SignedUP status: $status');
        }

        widget.onSignedIn();
      } catch (e) {
        print('Error $e');
      }
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _signIn() {
    formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.SIGNIN;
    });
  }

  void _signUp() {
    formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.SINGUP;
    });
  }
}
