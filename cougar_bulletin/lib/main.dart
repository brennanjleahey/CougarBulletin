// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cougar_bulletin/notifier/post_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feed_page.dart';
import 'login_page.dart';

// import 'feed_page.dart';
// import 'login_page.dart';
import 'notifier/auth_notifier.dart';


 void main() => runApp(MultiProvider(
   providers: [
     ChangeNotifierProvider(
       create: (context) => AuthNotifier(),
     ),
     ChangeNotifierProvider(
       create: (context) => PostNotifier(),
     ),
   ],
   child: MyApp(),
 ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cougar Bulletin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          try {
            
            if (notifier.isUserPresent()){
              return FeedPage();
            }
            else{
              return Login();
            }

            }
            catch(err){   
                  print(err);   
                  return Login();
          }
          
          //return notifier.isUserPresent() ? FeedPage() : Login();
        },
      ),
    );
  }
}

//class MyApp extends StatelessWidget {
//
//  @override
//    Widget build(BuildContext context){
//        return MaterialApp(
//          title: 'Cougar Bulletin Login',
//          theme: ThemeData.dark().copyWith(
//            textTheme: TextTheme(
//              body1: TextStyle(color:Colors.black38),
//            ),
//          ),
//          initialRoute: WelcomeScreen.id,
//          routes: {
//            WelcomeScreen.id:(context) => WelcomeScreen(),
//            LoginScreen.id: (context) => LoginScreen(),
//            RegistrationScreen.id:(context)=>RegistrationScreen(),
//          },
//           home: Consumer<AuthNotifier>(
//             builder: (context, notifier, child){
//               return notifier.user != null ? FeedPage() : Login();
//             },
//           )
//           
//        );
//  }
//}