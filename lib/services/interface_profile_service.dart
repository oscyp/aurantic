import 'package:aurantic/domain_model/profile.dart';

abstract class IProfileService{
  Future<Profile> getUser(int id);
}