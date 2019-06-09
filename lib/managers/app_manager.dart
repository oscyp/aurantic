import 'package:aurantic/domain_model/car_report_detail.dart';
import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:rx_command/rx_command.dart';

class AppManager {
  RxCommand<int, Profile> getProfileCommand;
  RxCommand<String, String> searchTextChangedCommand;
  RxCommand<String, List<CarReportDetail>> getReportsForLicenseCommand;
  RxCommand<String, bool> addLicenseToObservedCommand;
  RxCommand searchCommand;
  RxCommand<String, bool> removeLicenseFromObservedCommand;
  RxCommand<String, List<DisplayCar>> getLicensesCommand;
  RxCommand<bool,bool> mockChangeCommand;

  static const int ProfileId = 1;

  AppManager() {

    //** Mock section **//
    mockChangeCommand = RxCommand.createSync<bool, bool>((value) { swapDatabaseService(value); return value;}, initialLastResult: true);
    //** Mock section **//

    getProfileCommand = RxCommand.createAsync<int, Profile>(
      sl.get<IDatabaseService>().getUser,
    );    

    getLicensesCommand =RxCommand.createAsync<String, List<DisplayCar>>((s) => sl.get<IDatabaseService>().getLicenses(s, ProfileId));

    searchTextChangedCommand = RxCommand.createSync<String, String>((s) => s);
    
    getReportsForLicenseCommand = RxCommand.createAsync<String, List<CarReportDetail>>(
        (plate) => sl.get<IDatabaseService>().getReportsForLicense(plate));

    addLicenseToObservedCommand =RxCommand.createAsync<String, bool>(
      (s) => sl.get<IDatabaseService>().addToFavorites(searchTextChangedCommand.lastResult, ProfileId));
    
    searchCommand =RxCommand.createAsyncNoParamNoResult(() => sl.get<IDatabaseService>().searchAndGetLicenses(searchTextChangedCommand.lastResult));
    
    removeLicenseFromObservedCommand =RxCommand.createAsync<String, bool>((s) =>
      sl.get<IDatabaseService>().removeLicenseFromObserved(s, ProfileId)
    );

    //listeners

    addLicenseToObservedCommand.listen((onData) => searchTextChangedCommand.execute(null));
    addLicenseToObservedCommand.listen((onData) => () => getLicensesCommand.execute());
    removeLicenseFromObservedCommand.listen((d) => getLicensesCommand.execute());

    searchTextChangedCommand
        .debounce(Duration(milliseconds: 500))
        .listen(getLicensesCommand);
  }

}
