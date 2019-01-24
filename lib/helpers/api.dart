import 'constants.dart';
import 'package:http/http.dart' as http;
class API {
  static Future getCars(){
    var url = API_URL + "Cars/Get";

    return http.get(url);
  }
}