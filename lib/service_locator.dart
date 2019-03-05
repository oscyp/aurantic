import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/managers/report_manager.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:get_it/get_it.dart';

GetIt sl = new GetIt();

void setUpServiceLocator() {
  registerServices();
  registerManagers();
}

void registerServices() {
  sl.registerSingleton<IApiService>(new ApiServiceMock());
}

void registerManagers() {
  sl.registerSingleton<ProfileManager>(new ProfileManager());
  sl.registerSingleton<ReportManager>(new ReportManager());
}
