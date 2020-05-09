
import 'package:cougar_bulletin/feed_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/post_api.dart';
import 'login_page.dart';
import 'notifier/auth_notifier.dart';



class ProfilePage extends StatefulWidget {
    @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    //PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    //getPosts(postNotifier);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text('My Profile',
          style: TextStyle(
            fontFamily:'Dancing Script',
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: new Color(0xFFFFF8E1)
          ),
          textAlign: TextAlign.center,),
          actions: <Widget>[
            FlatButton(
              onPressed: () => {Navigator.pop(context),signout(authNotifier)},
              child: Text(
                "Logout",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20, color: Colors.white),
                ))
          ],
        ),
      body: Center(
        child: Container(
           margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                     Text('Display Name - ', 
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20),),
                     Text(authNotifier.isUserPresent()? authNotifier.user.displayName : 'null',
                     style: TextStyle(
                       fontSize: 20),),
                  ],
                ),
               SizedBox(height: 20,),
               Row(
                  children: <Widget>[
                     Text('Email - ', 
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20),),
                     Text(authNotifier.isUserPresent()? authNotifier.user.email : 'null',
                     style: TextStyle(
                       fontSize: 20),),
                  ],
                ),

              ]
              ),)
      
    ));
  }
}