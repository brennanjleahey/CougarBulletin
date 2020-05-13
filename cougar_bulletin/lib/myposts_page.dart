import 'package:cougar_bulletin/notifier/auth_notifier.dart';
import 'package:cougar_bulletin/postdetail_page.dart';
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
    PostNotifier postNotifier = Provider.of<PostNotifier>(context);

    Future<void> _refreshListByAuthor() async {
        getPostsByAuthor(postNotifier, authNotifier.user.displayName);
    }
    
    return Scaffold(
            backgroundColor: Color(0xffb2ebf2),
            body: RefreshIndicator(
            onRefresh:() => _refreshListByAuthor(),
            child:  ListView.separated(itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(postNotifier.postList[index].title),
              subtitle: Text(postNotifier.postList[index].category + ' - ' + postNotifier.postList[index].author),
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
            appBar: AppBar(
              title: Text('My Posts', 
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily:'Dancing Script',
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: new Color(0xFFFFF8E1)
          ),
         ),),
            
            

            
            );
    
  }


}