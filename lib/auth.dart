// import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

abstract class IAuth {
  Future<bool> signIn(String email, String password);
  Future<bool> signUp(String email, String password);
  Future<void> signOut();
  Future<String> getCurrentUser();
}

class Auth implements IAuth {
  bool _loggedStatus;
  @override
  Future<bool> signIn(String email, String password) async {
    // try {
    var request = await HttpClient().getUrl(Uri.parse(
        'http://localhost:5000/api/Authentication/Login?email=${email}&password=${password}'));
    var response = await request.close();
    var responseBody = await response.transform(Utf8Decoder()).join();

    _loggedStatus = (responseBody.toLowerCase() == 'true');
    return _loggedStatus;
    // } catch (e) {
    //   e.toString();
    // }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return null;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    // return await http
    //     .get(
    //         "http://192.168.1.107:5666/api/Authentication/Login?email=${email}&password=${password}")
    //     .then((response) {
    //   return (response.body.toLowerCase() == 'true');
    // });
  }

  @override
  Future<String> getCurrentUser() async {
    return await null;
  }
}
