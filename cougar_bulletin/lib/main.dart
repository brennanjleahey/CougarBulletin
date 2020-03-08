// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth.dart';
import 'root_page.dart';

void main() {
  runApp(new MyApp());
}
 
class MyApp extends StatelessWidget {

  @override
    Widget build(BuildContext context){

        return new MaterialApp(
          title: 'Cougar Bulletin Login',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new LoginPage(auth: new Auth())
        );
  }
}