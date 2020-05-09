
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cougar_bulletin/api/post_api.dart';
import 'package:cougar_bulletin/feed_page.dart';
import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/post.dart';
import 'notifier/auth_notifier.dart';

class PostForm extends StatefulWidget {

  final bool isUpdating;

  PostForm({@required this.isUpdating});
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Post _currentPost;
  @override

  void initState() {
    super.initState();
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    if (postNotifier.currentPost != null){
      _currentPost = postNotifier.currentPost;
    }
    else {
      _currentPost = Post();
    }
  }

  Widget _buildTitleField(){  
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      initialValue: _currentPost.title,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value){
        if (value.isEmpty){
          return 'Title is required';
        }
        if (value.length < 3 || value.length > 33){
          return 'Title must be more than 3 and less than 33 characters';
        }
        return null;
      },
    onSaved: (String value){
      _currentPost.title = value;
    },
    );
  }

String dropdownValue = 'General';

  Widget _buildCategoryField(){
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          _currentPost.category = newValue;
        });
      },
      items: <String>['General', 'News', 'Trade', 'Event', 'Opportunity'].map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
        value: dropDownStringItem,
        child: Text(dropDownStringItem),
      );
      }).toList(),
      
      );
  }

  Widget _buildContactField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Contact'),
      initialValue: _currentPost.contact,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value){
        if (value.isEmpty){
          return 'Contact is required';
        }
        if (value.length < 10 || value.length > 25){
          return 'Contact must be 10-25 characters';
        }
        return null;
      },
    onSaved: (String value){
      _currentPost.contact = value;
    },
    );
  }
  Widget _buildBodyField(){
  return TextFormField(
    decoration: InputDecoration(labelText: 'Body'),
    maxLines: 6,
      initialValue: _currentPost.body,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value){
        if (value.isEmpty){
          return 'Body is required';
        }
        if (value.length < 4 || value.length > 250){
          return 'Body must be 4-250 characters';
        }
        return null;
      },
    onSaved: (String value){
      _currentPost.body = value;
    },
    );
  } 

  _savePost(context, AuthNotifier authNotifier) {

    if (!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();

    if (widget.isUpdating){
    _currentPost.lastUpdate = new Timestamp.now();
    }
    else
    {
      _currentPost.createdAt = new Timestamp.now();
      _currentPost.lastUpdate = _currentPost.createdAt;
    }

    // Todo: set current post's author to current user
    _currentPost.author = authNotifier.user.displayName;
    uploadPost(_currentPost, widget.isUpdating);

    print("Title: ${_currentPost.title}");
    print("Category: ${_currentPost.category}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Post"),
          content: new Text("Post Successful."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context){
                    return FeedPage();
                    })
                   );
              }
            ),
          ],
        );
      });
  }



  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
        title: Text("Post Form",
        style:TextStyle(
            fontFamily: 'Dancing Script',
            fontSize: 40.0,
            fontWeight:FontWeight.bold,
            color: new Color(0xFFFFF8E1)
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(children: <Widget>[
            SizedBox(height: 10),
            Text( widget.isUpdating ? "Edit Post" : "Create Post",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Lobster Two',fontSize: 30),),
            SizedBox(height: 10),
          _buildTitleField(),
          Row(
            children: <Widget>[
              Text('Category',
              style: TextStyle(fontSize: 20)),
              SizedBox(width: 10,),
              _buildCategoryField()
            ],
          ),
          
          _buildContactField(),
          _buildBodyField(),
          ],
          )
          ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _savePost(context, authNotifier),
            child: Icon(Icons.navigation),
            backgroundColor: Colors.blue,
            ),
    );
  }
}