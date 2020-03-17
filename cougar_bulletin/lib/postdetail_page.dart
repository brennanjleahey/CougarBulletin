import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'postcreate_page.dart';

class PostDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier =
        Provider.of<PostNotifier>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text(postNotifier.currentPost.title),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Text(postNotifier.currentPost.createdAt.toString()),
                Text(postNotifier.currentPost.body,
                    style: TextStyle(
                      fontSize: 20,
                    ))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return PostCreate();
              }),
            );
          },
        ));
  }
}
