import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:cougar_bulletin/post_form.dart';
import 'package:cougar_bulletin/postdetail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/post_api.dart';
import 'notifier/auth_notifier.dart';

class FeedPage extends StatefulWidget {
  static const String id = 'feedPage';
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    // getCurrentUser();
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    getPosts(postNotifier);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    PostNotifier postNotifier = Provider.of<PostNotifier>(context);

    Future<void> _refreshList() async {
      getPosts(postNotifier);
    }
    print("building feed");

    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout',
                style: new TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => signout(authNotifier),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh:() => _refreshList(),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // Todo: leading image Coding with Curry Part 2 15:18
              title: Text(postNotifier.postList[index].title),
              subtitle: Text(postNotifier.postList[index].author),
              onTap: (){
                postNotifier.currentPost = postNotifier.postList[index];
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return PostDetail();
                  })
                );
              },
            );
          },
          itemCount: postNotifier.postList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          postNotifier.currentPost = null;
          Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){
                    return PostForm(isUpdating: false);
        },));})
    );
  }
}
