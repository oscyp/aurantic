import 'dart:io';

import 'package:aurantic/service_locator.dart';
import 'package:aurantic/services/api_service.dart';
import 'package:rx_command/rx_command.dart';
import 'package:image_picker/image_picker.dart';

class ReportManager{
  RxCommand<String, String> textChangedCommand;
  RxCommand<String, List<String>> udpateLicenseCommand;
  RxCommand<void, File> getImageFromGallery;
  RxCommand<void, List<String>> getNotifyReasons;

  ReportManager(){
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);
    udpateLicenseCommand = RxCommand.createAsync<String, List<String>>(
      sl.get<IApiService>().searchAndGetLicenses,
    );
    
    getImageFromGallery = RxCommand.createAsyncNoParam(() => ImagePicker.pickImage(source: ImageSource.gallery));

    getNotifyReasons = RxCommand.createAsyncNoParam<List<String>>(sl.get<IApiService>().getReasons);

    textChangedCommand
      .debounce(new Duration(milliseconds:  500))
      .listen(udpateLicenseCommand);

  }
}
