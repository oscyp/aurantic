import 'package:aurantic/domain_model/profile.dart';
import 'package:aurantic/managers/profile_manager.dart';
import 'package:aurantic/service_locator.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<Profile>(
            initialData: Profile('DD',''),
            stream: serviceLocator.get<ProfileManager>().getProfileCommand,
            builder: (context, snapshot){
                return Text('Name: ${snapshot.data.name}');
            },
          )
            
        ],
      ),
    );
  }
}