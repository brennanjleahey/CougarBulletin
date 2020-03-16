import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/post_api.dart';
import 'notifier/auth_notifier.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
  }

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    getPosts(postNotifier);
    super.initState();
  }

  @override
    Widget build(BuildContext context){
      AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      PostNotifier postNotifier = Provider.of<PostNotifier>(context);

    Future<void> _refreshList() async {
      getPosts(postNotifier);
    }
    
      return Scaffold(
        appBar: AppBar(
          title: Text(authNotifier.user != null ? authNotifier.user.displayName : "Feed",),
          actions: <Widget>[
           FlatButton(
              child: Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => signout(authNotifier),
              )
          ],
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(postNotifier.postList[index].title),
              subtitle: Text(postNotifier.postList[index].body),
            );
          },
          itemCount: postNotifier.postList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
              );
          },          
      ),
      );
    }
}
