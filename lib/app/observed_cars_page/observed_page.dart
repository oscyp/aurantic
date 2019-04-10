import 'package:aurantic/app/cars_page/car_page.dart';
import 'package:aurantic/domain_model/display_car.dart';
import 'package:aurantic/domain_model/observed_car.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ObservedPage extends StatefulWidget {
  @override
  _ObservedPageState createState() => _ObservedPageState();
}

class _ObservedPageState extends State<ObservedPage> {
  TextEditingController _searchController;
  @override
  void initState() {
    _searchController = new TextEditingController();
    sl.get<AppManager>().getLicensesCommand.execute();
    // Future.delayed(Duration(seconds: 2), () => sl.get<ProfileManager>().getObservedLicenses.execute());

    super.initState();
  }

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

  Widget buildRow(BuildContext context, DisplayCar item) {
    return Card(
      color: CARD_COLOR,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListTile(
        leading: item.isObserved ? IconButton(
          icon: Icon(Icons.star, color: Colors.yellow,),
          onPressed: () => sl.get<AppManager>().removeLicenseFromObservedCommand(item.licensePlate),)
          
          :null
          ,
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
    );
  }

  Widget buildAddAction(){
    return StreamBuilder<bool>(
      initialData: false,
      stream: sl.get<AppManager>().addLicenseToObservedCommand.isExecuting,
      builder: (context, snapshot) {
        if(snapshot.data == true){
          return new CircularProgressIndicator();
        }
        else return IconButton(
                icon: Icon(Icons.add),
                onPressed: sl.get<AppManager>().addLicenseToObservedCommand,
              );
          },
        // if (snapshot.data == true) {
        //   final snackbar =SnackBar(content: Text('Successfully added'), duration: Duration(seconds: 2),);
        //   Scaffold.of(context).showSnackBar(snackbar);
        // }
        // else{
        //   final snackbar =SnackBar(content: Text('Problem with adding'), duration: Duration(seconds: 2),);
        //   Scaffold.of(context).showSnackBar(snackbar);
        // }
    );
  }

  Widget buildSearchAction(){
    return StreamBuilder<String>(
      initialData: null,
      stream: sl.get<AppManager>().searchTextChangedCommand,
      builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data.isNotEmpty){
            return IconButton(
              icon: Icon(Icons.clear),
              onPressed:() { 
                sl.get<AppManager>().searchTextChangedCommand.execute(null);
                _searchController.clear();
                }
              );
          }
          else{
            return IconButton(
              icon: Icon(Icons.search),
              onPressed: sl.get<AppManager>().searchCommand);
          }
      },
    );
  }
  List<Widget> buildAppBarActions(){
    return [
      buildSearchAction(),
      buildAddAction()
      ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: TextField(
              controller: _searchController,
              decoration: new InputDecoration(
                hintText: 'Search or add to observed...'
              ),
              onChanged: sl.get<AppManager>().searchTextChangedCommand
              ),
            actions: buildAppBarActions()
        ),
                
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: RxLoader<List<DisplayCar>>(
            radius: 25.0,
            commandResults:
                sl.get<AppManager>().getLicensesCommand.results,
            dataBuilder: (context, data) {
              data.sort((x, y) => x.licensePlate.compareTo(y.licensePlate));
              data.sort((x, y) => y.isObserved.toString().compareTo(x.isObserved.toString()));
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => buildRow(context, data[index]),
              );
            },
            placeHolderBuilder: (context) => Center(child: Text('no data')),
            errorBuilder: (context, ex) => Center(
                  child: Text('Error: ${ex.toString()}'),
                ),
          ),
        ));
  }
}
