import 'package:aurantic/auth.dart';
import 'package:aurantic/screens/home_screen.dart';
import 'package:aurantic/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  final IAuth auth;

  RootPage({this.auth});

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { NOT_DETERMIND, NOT_SIGNED_IN, SIGNED_IN }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMIND;

  @override
  void initState() {
    super.initState();

    widget.auth.getCurrentUser().then((userId) {
      setState(() {
        authStatus =
            // userId == null ? AuthStatus.NOT_SIGNED_IN : AuthStatus.SIGNED_IN;
             AuthStatus.SIGNED_IN;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.SIGNED_IN;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_SIGNED_IN;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMIND:
      //break;
      case AuthStatus.NOT_SIGNED_IN:
        return new LoginScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.SIGNED_IN:
        return new HomeScreen(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}
