import 'dart:io';

import 'package:aurantic/domain_model/report.dart';
import 'package:aurantic/service_locator.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:image_picker/image_picker.dart';

class ReportManager {
  RxCommand<String, String> textChangedCommand;
  RxCommand<String, List<String>> udpateLicenseCommand;
  RxCommand<void, File> getImageFromGallery;
  RxCommand<void, List<String>> getNotifyReasons;
  RxCommand<Report, bool> saveReport;

  ReportManager() {
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);
    udpateLicenseCommand = RxCommand.createAsync<String, List<String>>(
      sl.get<IDatabaseService>().searchAndGetLicenses,
    );

    getImageFromGallery = RxCommand.createAsyncNoParam(
        () => ImagePicker.pickImage(source: ImageSource.gallery));

    getNotifyReasons = RxCommand.createSyncNoParam(() {
      sl.get<IDatabaseService>().getReasons();
    });

    saveReport = RxCommand.createAsync<Report, bool>(
        (report) => sl.get<IDatabaseService>().saveReport(report));

    textChangedCommand
        .debounce(new Duration(milliseconds: 500))
        .listen(udpateLicenseCommand);
  }
}
