import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/services/interface_profile_service.dart';
import 'package:aurantic/services/profile_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = new GetIt();

void setUpServiceLocator(){
  serviceLocator.registerSingleton<IProfileService>(new ProfileServiceMock());
  serviceLocator.registerSingleton<ProfileManager>(new ProfileManager());
}

