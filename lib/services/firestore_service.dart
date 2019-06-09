import 'package:aurantic/domain_model/car_report_detail.dart';
import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirestoreService implements IDatabaseService{

  @override
  Future<bool> addToFavorites(String plateNumber, int userId) async {

    var isFound = false;
    await Firestore.instance.collection('plates').where('number', isEqualTo: plateNumber).getDocuments().then((x) => isFound = x.documents.length > 0);

    if(!isFound){
      await Firestore.instance.collection('plates').add({'number': plateNumber});
    }

    Firestore.instance.collection('favorites').add({
      'number': plateNumber,
      'user_id': userId,
      'notifications': 0
    });
    return null;
  }

  @override
  Future<List<DisplayCar>> getLicenses(String searchText, int userId) async{
    
    if (searchText != null && searchText.isNotEmpty) {
      return Firestore.instance.collection('plates')
      .where('number', isEqualTo: searchText)
      .getDocuments()
      .then((x) => x.documents.map((x) => DisplayCar.base(x['number'], false, 0)).toList());
    }

    else{

       return Firestore.instance.collection('favorites')
    .getDocuments()
    .then((x) => x.documents.where((y) => y.data['user_id'] == userId)
      .map((y) => DisplayCar.base(y.data['number'].toString(), true, y.data['notifications']) ).toList());
    }
  }

  @override
  Future<List<String>> getReasons() {
    // TODO: implement getReasons
    return null;
  }

  @override
  Future<List<CarReportDetail>> getReportsForLicense(String plate) async {

    return Firestore.instance.collection('reports')
    .where('plate', isEqualTo: plate)
    .getDocuments()
    .then((result) => result.documents.map((x) => 
    CarReportDetail.full(
      x.data['author'], 
      DateTime.fromMicrosecondsSinceEpoch((x.data['date'] as Timestamp).microsecondsSinceEpoch), 
      x.data['message'],
      x.data['images'] != null ? List<String>.from(x.data['images']) : new List<String>(), 
      x.data['localisation'] !=null ? new LatLng((x.data['localisation'] as GeoPoint).latitude, (x.data['localisation'] as GeoPoint).longitude) : new LatLng(0,0))
    ).toList())
    .catchError((e)=> print(e));
  }

  @override
  Future<Profile> getUser(int id) {
    // TODO: implement getUser
    return null;
  }

  @override
  Future<bool> removeLicenseFromObserved(String s, int i) async {
    Firestore.instance.collection('favorites')
    .where('number', isEqualTo: s)
    .where('user_id', isEqualTo: i)
    .getDocuments().then((result) => result.documents.forEach((x) => x.reference.delete()));
    
    return null;
  }

  @override
  Future<bool> saveReport(Report report) async {
    await Firestore.instance.collection('reports').add({
      'date': report.date,
      'author': 'testest',
      'message': report.message,
      'images': report.files,
      'plate': report.licensePlate,
      'localisation': GeoPoint(report.latitude, report.longitude)
    }).catchError((error) => print(error));

    var favsQuery = Firestore.instance.collection('favorites').where('number', isEqualTo: report.licensePlate).getDocuments();

    var ids = new Map<String, int>();
    await favsQuery.then((result) => result.documents.forEach((x) => ids.putIfAbsent(x.documentID, () => x.data['notifications']))).catchError((e) => print(e));

    ids.forEach((x, y) => Firestore.instance.collection('favorites').document(x).updateData({'notifications': y + 1}));
    

    return null;
  }

  @override
  Future<List<String>> searchAndGetLicenses(String searchText) async {
    
    if (searchText != null && searchText.isNotEmpty) {
      return Firestore.instance.collection('plates')
      .where('number', isEqualTo: searchText)
      .getDocuments()
      .then((x) => x.documents.map((x) => x.data['number'] as String).toList());
    }

    else return null;
  }


}