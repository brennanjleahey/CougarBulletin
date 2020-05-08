import 'package:cougar_bulletin/notifier/auth_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/post_api.dart';
import 'notifier/post_notifier.dart';

class MyPosts extends StatefulWidget {
  
  @override
  _MyPostsState createState() => _MyPostsState();

}

class _MyPostsState extends State<MyPosts> {


@override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    getPosts(postNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold();
  }


}