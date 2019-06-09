import 'package:aurantic/domain_model/car_report_detail.dart';
import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/domain_model/report.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class IDatabaseService {
  Future<Profile> getUser(int id);
  Future<List<String>> searchAndGetLicenses(String searchText);
  Future<List<String>> getReasons();
  Future<bool> saveReport(Report report);
  Future<List<CarReportDetail>> getReportsForLicense(String plate);
  Future<bool> addToFavorites(String s, int i);
  Future<bool> removeLicenseFromObserved(String s, int i);
  Future<List<DisplayCar>> getLicenses(String searchText, int userId);
}

class DatabaseMock implements IDatabaseService {
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

    var list = new List<String>.from(
        ['Reason1', 'Reason2', 'Reason3', 'Reason4', 'Reason5']);

    return list;
  }

  @override
  Future<bool> saveReport(Report report) async {
    try{
    var reportDetail = new CarReportDetail.full("Zbyszek Holinoga", report.date, report.message, report.files, null);
    MockData.reportsDetails.add(reportDetail);

    }
    catch(e){
      print(e);
    }
    print("saveReport");
    return true;
  }

  @override
  Future<List<CarReportDetail>> getReportsForLicense(String plate) async {
    return MockData.reportsDetails;
  }

  @override
  Future<Report> getReportById(double id) async {
    return MockData.reports.firstWhere((x) => x.id == id);
  }

  @override
  Future<bool> addToFavorites(String s, int i) async {
    

    var index =MockData.cars.indexOf(s);

    if (!MockData.observedCars.containsKey(index)) {
      MockData.cars.add(s);
      var idx = MockData.cars.lastIndexOf(s);
      var oIdx = MockData.observedCars.keys.last + 1;
      MockData.observedCars.addAll({idx:0});
    }
    return Future.delayed(Duration(seconds: 3), () => true);
  }

  @override
  Future<bool> removeLicenseFromObserved(String s, int i) async {
    var index =MockData.cars.indexOf(s);
    MockData.observedCars.remove(index);
    return true;
  }

  @override
  Future<List<DisplayCar>> getLicenses(String searchText, int user) async {
    
    var list = MockData.cars;
    var result = new List<DisplayCar>();
    if (searchText != null && searchText.isNotEmpty) {
      list = list.where((x) => x.toUpperCase().contains(searchText.toUpperCase())).toList();
    }
    
    if (user!=null) {
      result = list.map((value) {
        var index = MockData.cars.indexOf(value);
        if(MockData.observedCars.containsKey(index)){
          return new DisplayCar.base(value, true, MockData.observedCars[index]);
        }
        else return new DisplayCar.base(value, false, 0);
      }).toList();
    }

    else{
      result =list.map((x) => new DisplayCar.base(x, false, 0));
    }
    return result;
  }
}

class MockData {
  static const String url = "test_url";
  static Map<int,int> observedCars =  <int, int>{
    1:3,
    2:6,
    3:4,
    4:5,
    5:0,
    6:1,
    7:1,
    8:4,
    9:15,
    10:23,
    11:9,
  };
  static List<String> cars = new List.from([
    'SZYS463',
'WW4564', 
'WW4564', 
'WA453453',
'WB45644', 
'DD8ESZKE',
'XXWEWR3',
'SADF9AS',
'X1293FA3',
'ASDF123',
'AAA23',
'ASADFA', 
    "WXW2522",
    "ABTT555",
    "DD4WPDD",
    "XX22WFA",
    "DW45012",
    "CB51113",
    "CB41113",
    "CB31413",
    "EB51113",
    "EB57883",
  ]);
  static List<Report> reports = new List<Report>.from([
    new Report.full(1, 50.049683, 19.944544, 'SZYS463', 'reason1',
        'jakas tam wiadomosc 1', new DateTime(2019, 04, 05, 15, 11, 0, 0)),
    new Report.full(2, 50.049683, 19.944544, 'SZYS463', 'reason1',
        'jakas tam wiadomosc 2', new DateTime(2019, 05, 03, 15, 11, 0, 0)),
    new Report.full(3, 50.049683, 19.944544, 'SZYS463', 'reason1',
        'jakas tam wiadomosc 3', new DateTime(2019, 06, 11, 15, 11, 0, 0)),
    new Report.full(4, 50.049683, 19.944544, 'SZYS463', 'reason2',
        'jakas tam wiadomosc 4', new DateTime(2019, 07, 12, 15, 11, 0, 0)),
    new Report.full(5, 50.049683, 19.944544, 'SZYS463', 'reason2',
        'jakas tam wiadomosc 5', new DateTime(2019, 08, 3, 15, 11, 0, 0)),
    new Report.full(6, 50.049683, 19.944544, 'SZYS463', 'reason2',
        'jakas tam wiadomosc 6', new DateTime(2019, 09, 5, 14, 12, 0, 0)),
  ]);

   static List<CarReportDetail> reportsDetails = new List<CarReportDetail>.from([
    // new CarReportDetail.full('Adam Nawałka', new DateTime(2019, 04, 03, 15, 11, 0, 0), "Rozbite światło! Do tego coś Ci ten tłumik burczy leszczu jeden, co na dieslu jeździsz. Huncwocie jeden, Ty!", null, null),
    // new CarReportDetail.full('Andzrej Grabowski', new DateTime(2019, 04, 11, 13, 11, 0, 0), "Maska otwarta!", null, null),
    // new CarReportDetail.full('Marian Paździoch', new DateTime(2019, 04, 12, 11, 11, 0, 0), "Bagażnik otwarty!", null, null),
    // new CarReportDetail.full('Helena Kiepska', new DateTime(2019, 04, 05, 13, 11, 0, 0), "Przebita opona!", null, null),
    new CarReportDetail.full('A. Nawałka', new DateTime(2019, 04, 03, 15, 11, 0, 0), "Rozbite światło! Do tego coś Ci ten tłumik burczy leszczu jeden, co na dieslu jeździsz. Huncwocie jeden, Ty!", null, null),
    new CarReportDetail.full('A. Grabowski', new DateTime(2019, 04, 11, 13, 11, 0, 0), "Maska otwarta!", null, null),
    new CarReportDetail.full('M. Paździoch', new DateTime(2019, 04, 12, 11, 11, 0, 0), "Bagażnik otwarty!", null, null),
    new CarReportDetail.full('H. Kiepska', new DateTime(2019, 04, 05, 13, 11, 0, 0), "Przebita opona!", null, null),
    
  ]);
}
