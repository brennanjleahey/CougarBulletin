
import 'package:cougar_bulletin/feed_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/post_api.dart';
import 'notifier/auth_notifier.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
        
    return Scaffold(
      drawer:  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
               child: Text("Menu",style: TextStyle(color: Colors.white, fontSize: 25),  )),
            ListTile(title: Text('Feed'),
            onTap: () =>{Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context){return FeedPage();},))},),
            ListTile(title: Text('My Posts'),
             onTap: () =>{Navigator.of(context).pop()},),
             ListTile(title: Text('Help'),
             onTap: () =>{Navigator.of(context).pop()},),
             ListTile(title: Text('Logout'),
             onTap: () =>{signout(authNotifier)},),
          ],)
    ),
      appBar: AppBar(
          centerTitle: true,
          title: Text('My Profile',
          textAlign: TextAlign.center,),
        ),
      body: Center(
        child: Container(
           margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 10),
                SizedBox(width: 30),

              ]
              ),)
      
    ));
  }
}