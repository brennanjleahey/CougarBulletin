import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:cougar_bulletin/post_form.dart';
import 'package:cougar_bulletin/postdetail_page.dart';
import 'package:cougar_bulletin/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/post_api.dart';
import 'login_page.dart';
import 'notifier/auth_notifier.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedPage extends StatefulWidget {
  
  @override
  _FeedPageState createState() => _FeedPageState();

}

class _FeedPageState extends State<FeedPage> {
  bool activeSearch;
  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    getPosts(postNotifier);
    super.initState();
    activeSearch = false;
  }

String dropdownValue = 'General';

 PreferredSizeWidget _appBar(PostNotifier postNotifier) {
    if (activeSearch) {
      return AppBar(

        leading: Icon(Icons.search),
        title: TextField(
          decoration: InputDecoration(
            //contentPadding:,
            hintText: "Sort by Category",
          ),
        onTap: () => {},
        ),
        
        actions: <Widget>[
          
          SizedBox(width: 10),
          DropdownButton<String>(
            value: dropdownValue,
            
            onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              if (newValue == "All")
              {
                getPosts(postNotifier);
              }
              else{
                getPostByCategory(postNotifier, newValue);
              }

        });
      },
      items: <String>['All','General', 'News', 'Trade', 'Event', 'Opportunity'].map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
        value: dropDownStringItem,
        child: Text(dropDownStringItem),
      );
      }).toList(),
      
      ),
      IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() => activeSearch = false),
          ),
        ],
        
      );
    } else {
      return AppBar(
         backgroundColor: Colors.blueAccent,
        title: Text('Feed',
          style:TextStyle(
          fontFamily: 'Dancing Script',
          fontSize: 40.0,
          fontWeight:FontWeight.bold,
          color: new Color(0xFFFFF8E1)  
          )
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearch = true),
          ),
        ],
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    PostNotifier postNotifier = Provider.of<PostNotifier>(context);

    Future<void> _refreshList() async {
      if (activeSearch = false){
        getPosts(postNotifier);
      }
      
    }

    print("building feed");
    return Scaffold(
      backgroundColor: Color(0xffb2ebf2),

      drawer:  Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                   DrawerHeader(
                     child: Text("Menu",style: TextStyle(color: Colors.black, fontSize: 25)  ),
                      
                     decoration: new BoxDecoration(
                       color:Colors.blueAccent
                     ),
                    ),
                     
                  ListTile(title: Text('Profile'),
                    onTap: () =>{
                        postNotifier.currentPost = null,
                        Navigator.pop(context),
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context){return ProfilePage();},))}),
                  ListTile(title: Text('My Posts'),
                   onTap: () =>{Navigator.of(context).pop()},),
                   ListTile(title: Text('Help'),
                   onTap: () =>{Navigator.of(context).pop()},),
                   ListTile(title: Text('Logout'),
                   onTap: () =>{  Navigator.pop(context), signout(authNotifier)},),
                ],)
          ),
          appBar: _appBar(postNotifier),
      //appBar: AppBar(
      //  centerTitle: true,
      //  title: Text("Feed"),
      //  actions: <Widget>[
      //    
      //  ],
      //),
      
      body: RefreshIndicator(
        onRefresh:() => _refreshList(),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // Todo: leading image Coding with Curry Part 2 15:18
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
      
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          postNotifier.currentPost = null;
          Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context){return PostForm(isUpdating: false);
        },));},

        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        ),
    );
  }
}
// class DataSearch extends SearchDelegate<String>{
//   @override
//   List<Widget> buildActions(BuildContext context) {
//       // TODO: implement buildActions
//       throw UnimplementedError();
//     }
  
//     @override
//     Widget buildLeading(BuildContext context) {
//       // TODO: implement buildLeading
//       throw UnimplementedError();
//     }
  
//     @override
//     Widget builResults(BuildContext context) {
//       // TODO: implement buildResults
//       throw UnimplementedError();
//     }
  
//     @override
//     Widget builSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
  
//}
