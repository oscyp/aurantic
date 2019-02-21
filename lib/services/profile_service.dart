import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/helpers/api.dart';
import 'package:aurantic/services/interface_profile_service.dart';

class ProfileServiceMock implements IProfileService{
  static String url = "test_url";

  @override
  Future<Profile> getUser(int id) async {
    
    Future.delayed(Duration(seconds: 2));

    return new Profile('Patryk', 'test@interia.pl');
  }

  
}