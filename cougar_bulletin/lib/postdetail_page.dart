import 'package:cougar_bulletin/feed_page.dart';
import 'package:cougar_bulletin/login_page.dart';
import 'package:cougar_bulletin/post_form.dart';
import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:cougar_bulletin/post_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'login_page.dart';
import 'notifier/auth_notifier.dart';

class PostDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(postNotifier.currentPost.title,
          textAlign: TextAlign.center,),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[ // TODO: image.network CwC Part 2 20:30
                SizedBox(height: 10),
                SizedBox(width: 30),
                Text("Created at: " + postNotifier.currentPost.createdAt.toDate().toString(),
                textAlign: TextAlign.center,),
                Text("Last Update: " + postNotifier.currentPost.lastUpdate.toDate().toString(),
                textAlign: TextAlign.center,),
                Text("Category: " + postNotifier.currentPost.category, 
                textAlign: TextAlign.left,),
                SizedBox(height: 40,),
                Text("From: " + postNotifier.currentPost.author,
                textAlign: TextAlign.left,
                  style: TextStyle(
                        fontSize: 20,
                        )),
                SizedBox(height: 10),
                Text(postNotifier.currentPost.body,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                        fontSize: 20,
                        )),
                SizedBox(height: 10,),
                Text("Contact: " + postNotifier.currentPost.contact,
                      style: TextStyle(
                        fontSize: 20))
              ],
            ),
          ),
        ),
        // Todo: condition - if the user did not make this post, then they cannot edit it
        // if (postNotifier.currentPost.author != authNotifier.user.displayName)
        floatingActionButton: Visibility(
          child: FloatingActionButton( 
          onPressed: () {
            if(authNotifier.user.displayName == postNotifier.currentPost.author)
            {
          Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return PostForm(isUpdating: true); // edit button
        },));}},
        child: Icon(Icons.edit),
        backgroundColor: Colors.white,
        ),
        visible: authNotifier.user.displayName == postNotifier.currentPost.author? true : false,
        )
        );
  }
}
