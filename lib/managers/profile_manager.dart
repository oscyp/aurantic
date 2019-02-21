import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/services/interface_profile_service.dart';
import 'package:rx_command/rx_command.dart';

class ProfileManager {
  RxCommand<int, Profile> getProfileCommand;

  ProfileManager(){
    getProfileCommand = RxCommand.createAsync<int, Profile>((_) =>
      serviceLocator.get<IProfileService>().getUser(_)
    );
  }
}