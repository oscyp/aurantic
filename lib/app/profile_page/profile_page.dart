import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    sl.get<ProfileManager>().getProfileCommand();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: RxLoader<Profile>(
              radius: 25.0,
              commandResults:
                  sl.get<ProfileManager>().getProfileCommand.results,
              dataBuilder: (context, data) => Text('Name: ${data.name}'),
              placeHolderBuilder: (context) => Center(child: Text("No Data")),
              errorBuilder: (context, ex) =>
                  Center(child: Text("Error: ${ex.toString()}")),
            ),
          )
          // children: <Widget>[
          //   StreamBuilder<Profile>(
          //     initialData: Profile('DD',''),
          //     stream: sl.get<ProfileManager>().getProfileCommand,
          //     builder: (context, snapshot){
          //         return Text('Name: ${snapshot.data.name}');
          //     },
          //   )
        ],
      ),
    );
  }
}
