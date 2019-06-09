import 'package:aurantic/managers/app_manager.dart';
import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:aurantic/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

GetIt sl = new GetIt();

void setUpServiceLocator() {
  registerServices();
  registerManagers();
  sl.allowReassignment = true;
}

void registerServices() {
  sl.registerSingleton<IDatabaseService>(new DatabaseMock());  
  // sl.registerSingleton<IDatabaseService>(new FirestoreService());
}

void registerManagers() {
  sl.registerSingleton<AppManager>(new AppManager());
  sl.registerSingleton<ReportManager>(new ReportManager());
}

void swapDatabaseService(bool mock){
  print("Mock: " + mock.toString());
  if (mock){
   sl.registerSingleton<IDatabaseService>(new DatabaseMock());
  }
  else sl.registerSingleton<IDatabaseService>(new FirestoreService());
}