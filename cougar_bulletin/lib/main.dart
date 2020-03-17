// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
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


/*void main() {
  runApp(new MyApp());
}
*/ 
class MyApp extends StatelessWidget {

  @override
    Widget build(BuildContext context){
        return MaterialApp(
          title: 'Cougar Bulletin Login',
          theme: ThemeData.dark().copyWith(
            textTheme: TextTheme(
              bodyText1: TextStyle(color:Colors.black38),
            ),
          ),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id:(context) => WelcomeScreen(),
            // 'login_screen': (context) => LoginScreen(),
          },
          // home: Consumer<AuthNotifier>(
          //   builder: (context, notifier, child){
          //     return notifier.user != null ? FeedPage() : Login();
          //   },
          // )
        );
  }
}