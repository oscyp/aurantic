import 'package:http/http.dart' as http;

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
    return await http
        .get(
            "http://192.168.1.2:5666/api/Authentication/Login?email=${email}&password=${password}")
        .then((response) {
      _loggedStatus = (response.body.toLowerCase() == 'true');
      return _loggedStatus;
    });
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return null;
  }

  @override
  Future<bool> signUp(String email, String password) async {
    return await http
        .get(
            "http://192.168.1.2:5666/api/Authentication/Login?email=${email}&password=${password}")
        .then((response) {
      return (response.body.toLowerCase() == 'true');
    });
  }

  @override
  Future<String> getCurrentUser() async {
    return await null;
  }
}
