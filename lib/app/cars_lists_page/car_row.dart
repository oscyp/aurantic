import 'package:aurantic/app/cars_page/car_page.dart';
import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/managers/app_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:aurantic/helpers/constants.dart';

class CarRow extends StatelessWidget {
  const CarRow({
    Key key,
    @required this.context,
    @required this.item,
  }) : super(key: key);

  final BuildContext context;
  final DisplayCar item;

  Widget chooseIcon(int notificationCount) {
    if (notificationCount == 0) return Icon(null);
    if (notificationCount == 1) return Icon(Icons.filter_1);
    if (notificationCount == 2) return Icon(Icons.filter_2);
    if (notificationCount == 3) return Icon(Icons.filter_3);
    if (notificationCount == 4) return Icon(Icons.filter_4);
    if (notificationCount == 5) return Icon(Icons.filter_5);
    if (notificationCount == 6) return Icon(Icons.filter_6);
    if (notificationCount == 7) return Icon(Icons.filter_7);
    if (notificationCount == 8) return Icon(Icons.filter_8);
    if (notificationCount == 9) return Icon(Icons.filter_9);
    if (notificationCount >= 10) return Icon(Icons.filter_9_plus);
    return Icon(null);
  }

  void onDismissed(SlideActionType actionType, DisplayCar item) {
    if(actionType == SlideActionType.secondary){
      sl.get<AppManager>().removeLicenseFromObservedCommand(item.licensePlate);
    }
    else if(actionType == SlideActionType.primary){
      sl.get<AppManager>().addLicenseToObservedCommand(item.licensePlate);
    }
  }

  List<Widget> rightSideActions() {
    return <Widget>[
      IconSlideAction(
        icon: Icons.delete,
        color: Colors.grey,
        onTap: () => print("remove"),
      )
    ];
  }

  List<Widget> leftSideActions() {
    return <Widget>[
      IconSlideAction(
        icon: Icons.star,
        color: Colors.green,
        foregroundColor: Colors.yellow,
        onTap: () => print("add"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(4.0), child: Slidable(
      delegate: SlidableDrawerDelegate(),
      slideToDismissDelegate: SlideToDismissDrawerDelegate(
        onWillDismiss: (actionType) {
          if (actionType == SlideActionType.secondary){
                      return showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete'),
                content: Text('Item will be deleted from observed'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          );
          }
        },
        onDismissed: (actionType) => onDismissed(actionType, item),
      ),
      key: Key(item.licensePlate),
      actions: leftSideActions(),
      secondaryActions: rightSideActions(),
      child: Card(
        elevation: 0.0,
        margin: EdgeInsets.all(0.0),
        color: CARD_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListTile(
          leading: item.isObserved ? IconButton(
            icon: Icon(Icons.star, color: Colors.yellow,),
            onPressed: () => sl.get<AppManager>().removeLicenseFromObservedCommand(item.licensePlate),)
            :null,
          title: Text(
            item.licensePlate,
            style: TextStyle(fontSize: 35.0),
          ),
          trailing: chooseIcon(item.notificationsCount),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new CarPage(item.licensePlate)));
          },
        ),
      )
    ));
  }

}
