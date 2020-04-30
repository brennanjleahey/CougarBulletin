
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier with ChangeNotifier {
  FirebaseUser _user;

  FirebaseUser get user => _user;
 
  void setUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  bool isUserPresent()
  {
    if (_user==null){
      return false;
    }
    return true;
  }


}