import 'package:aurantic/app/cars_lists_page/cars_list.dart';
import 'package:aurantic/helpers/constants.dart';
import 'package:aurantic/managers/app_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';

class CarsListPage extends StatefulWidget {
  @override
  _CarsListPageState createState() => _CarsListPageState();
}

class _CarsListPageState extends State<CarsListPage> {
  TextEditingController _searchController;
  @override
  void initState() {
    _searchController = new TextEditingController();
    sl.get<AppManager>().getLicensesCommand.execute(null);
    super.initState();
  }

  Widget buildAddAction(){
    return StreamBuilder<bool>(
      initialData: false,
      stream: sl.get<AppManager>().addLicenseToObservedCommand.isExecuting,
      builder: (context, snapshot) {
        if(snapshot.data == true){
          return Container(child: const CircularProgressIndicator(backgroundColor: Colors.red,));
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

  Widget buildMockSwitchAction(){
    return StreamBuilder<bool>(
      initialData: sl.get<AppManager>().mockChangeCommand.lastResult,
      stream: sl.get<AppManager>().mockChangeCommand,
      builder: (context, snapshot){
        return Row(
          children: <Widget>[
            Text("Mock: "),
            Switch(
              value: snapshot.data,
              onChanged: (bool value)  {
                sl.get<AppManager>().mockChangeCommand(value);
                },
              )
          ] 
        );
      },
    );
    
  }
  List<Widget> buildAppBarActions(){
    return [
      buildSearchAction(),
      buildAddAction(),
      buildMockSwitchAction()
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
                
        body: new CarsList()
      );
  }
}

