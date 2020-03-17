
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCreate extends StatefulWidget {
  PostCreate({Key key}) : super(key: key);

  @override
  _PostCreateState createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create A Post")),
      body: Text("Create a post"),
    );
  }
}