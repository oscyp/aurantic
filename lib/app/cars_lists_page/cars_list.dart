import 'package:aurantic/app/cars_lists_page/car_row.dart';
import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/managers/app_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class CarsList extends StatelessWidget {
  const CarsList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RxLoader<List<DisplayCar>>(
        radius: 25.0,
        commandResults: sl.get<AppManager>().getLicensesCommand.results,//sl.get<AppManager>().getLicensesCommand.results,
        dataBuilder: (context, data) {
          sortByLicensePlate(data);
          sortByObservedFlag(data);

          return ListView.builder(
            padding: EdgeInsets.all(4.0),
            itemCount: data.length,
            itemBuilder: (context, index) => new CarRow(context: context, item: data[index]),
          );
        },
        placeHolderBuilder: (context) => Center(child: Text('no data')),
        errorBuilder: (context, ex) => Center(
              child: Text('Error: ${ex.toString()}'),
            ),
      ),
    );
  }

  void sortByObservedFlag(List<DisplayCar> data) {
    data.sort((x, y) => y.isObserved.toString().compareTo(x.isObserved.toString()));
  }

  void sortByLicensePlate(List<DisplayCar> data) {
    data.sort((x, y) => x.licensePlate.compareTo(y.licensePlate));
  }
}

