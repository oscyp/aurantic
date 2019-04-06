import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/domain_model/observed_car.dart';
import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:rx_command/rx_command.dart';

class AppManager {
  RxCommand<int, Profile> getProfileCommand;
  // RxCommand<String, List<DisplayCar>> getObservedLicensesCommand;
  RxCommand<String, String> searchTextChangedCommand;
  RxCommand<String, List<Report>> getReportsForLicenseCommand;
  RxCommand<double, Report> getReportCommand;
  RxCommand<String, bool> addLicenseToObservedCommand;
  RxCommand searchCommand;
  RxCommand<String, bool> removeLicenseFromObservedCommand;
  RxCommand<String, List<DisplayCar>> getLicensesCommand;


  AppManager() {
    getProfileCommand = RxCommand.createAsync<int, Profile>(
      sl.get<IApiService>().getUser,
    );

    // getObservedLicensesCommand =
    //     RxCommand.createAsync<String, List<DisplayCar>>(
    //         (s) {
    //           return sl.get<IApiService>().getObservedLicenseByUser(s).then((cars) => cars.map((car) => new DisplayCar.base(car.licensePlate, true, car.notifications)).toList());
    //         } );
    
    getLicensesCommand =RxCommand.createAsync<String, List<DisplayCar>>((s) => sl.get<IApiService>().getLicenses(s,'Patryk'));

    searchTextChangedCommand = RxCommand.createSync<String, String>((s) => s);
    
    getReportsForLicenseCommand = RxCommand.createAsync<String, List<Report>>(
        (plate) => sl.get<IApiService>().getReportsForLicense(plate));
    
    getReportCommand = RxCommand.createAsync<double, Report>(
        (id) => sl.get<IApiService>().getReportById(id));

    addLicenseToObservedCommand =RxCommand.createAsync<String, bool>(
      (s) => sl.get<IApiService>().addLicenseToObservedCommand(searchTextChangedCommand.lastResult, 2)); //userID
    
    searchCommand =RxCommand.createAsyncNoParamNoResult(() => sl.get<IApiService>().searchAndGetLicenses(searchTextChangedCommand.lastResult));
    
    removeLicenseFromObservedCommand =RxCommand.createAsync<String, bool>((s) =>
      sl.get<IApiService>().removeLicenseFromObserved(s, 2)
    );

    //listeners

    addLicenseToObservedCommand.listen((onData) => searchTextChangedCommand.execute(null));

    removeLicenseFromObservedCommand.listen((d) => getLicensesCommand.execute());

    searchTextChangedCommand
        .debounce(Duration(milliseconds: 500))
        .listen(getLicensesCommand);
  }



}
