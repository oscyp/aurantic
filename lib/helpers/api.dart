import 'dart:convert';

import 'constants.dart';
import 'package:http/http.dart' as http;

class API {


  static Future getCars() {
    var url = API_URL + "Cars/Get";

    return http.get(url);
  }

  // static Future<bool> registerCar(Car car) async {
  //   var url = API_URL + "Cars/Register";
  //   var response = await http.post(url,
  //       body: json.encode(car), headers: {"Content-Type": "application/json"});

  //   return response.body.toLowerCase() == 'true';
  // }

  // static Future sendMessage(Message message) async {
  //   var url = API_URL + "Cars/Message";
  //   var dd = json.encode(message);
  //   http.post(url,
  //       body: json.encode(message),
  //       headers: {"Content-Type": "application/json"});
  // }
}
