import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/domain_model/report.dart';

abstract class IApiService {
  Future<Profile> getUser(int id);
  Future<List<String>> searchAndGetLicenses(String searchText);
  Future<List<String>> getReasons();
  Future<bool> saveReport(Report report);
}

class ApiServiceMock implements IApiService {
  static String url = "test_url";

  @override
  Future<Profile> getUser(int id) async {
    Future.delayed(Duration(seconds: 2));

    return new Profile('Patryk', 'test@interia.pl');
  }

  @override
  Future<List<String>> searchAndGetLicenses(String searchText) async {
    Future.delayed(Duration(seconds: 2));

    var list = new List<String>.from(['SZYS463', 'SW5556', 'WW43G33']);

    return list;
  }

  @override
  Future<List<String>> getReasons() async {
    Future.delayed(Duration(seconds: 2));

    var list =
        new List<String>.from(['Reason1', 'Reason2', 'Reason3', 'Reason4', 'Reason5']);

    return list;
  }

  @override
  Future<bool> saveReport(Report report) async {
    Future.delayed(Duration(seconds: 2));
    print("saveReport");
    return true;
  }
}
