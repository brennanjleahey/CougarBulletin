import 'package:cougar_bulletin/model/user.dart';
import 'package:cougar_bulletin/notifier/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'api/post_api.dart';

enum AuthMode { Signup, Login }

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  User _user = User();
AnimationController controller;
Animation animation;
  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();

    controller = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this, upperBound: 100
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    controller.forward();

    controller.addListener((){
        print(controller.value);
    });

  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    if (_authMode == AuthMode.Login) {
      String res = await login(_user, authNotifier);
      if (res != ''){
      _showDialogue(res);
      }
    } else { // TODO: Handle Firebase signup errors
      signup(_user, authNotifier);
    }
    
  }
  void _showDialogue(String err) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(err),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }


  Widget _buildDisplayNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Display Name",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 24, color: Colors.black),
      cursorColor: Colors.white,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Display Name is required';
        }

        if (value.length < 5 || value.length > 15) {
          return 'Display Name must be betweem 5 and 15 characters';
        }

        return null;
      },
      onSaved: (String value) {
        _user.displayName = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.emailAddress,
      initialValue: '@cougars.csusm.edu', 
      style: TextStyle(fontSize: 24, color: Colors.black),
      cursorColor: Colors.black,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        return null;
      },
      onSaved: (String value) {
        _user.email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(fontSize: 24, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Password must be betweem 5 and 20 characters';
        }

        return null;
      },
      onSaved: (String value) {
        _user.password = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(fontSize: 24, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building login screen");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Column(
                children: <Widget>[
                  
                  //Image(image: AssetImage('images/logo.jpg'), height: 150, width: 200,),
                  // Text(
                  //   "Please Sign In",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 36, color: Colors.white),
                  // ),
                  SizedBox(height: 16),
                  _authMode == AuthMode.Signup ? _buildDisplayNameField() : Container(),
                  _buildEmailField(),
                  _buildPasswordField(),
                  _authMode == AuthMode.Signup ? _buildConfirmPasswordField() : Container(),
                  SizedBox(height: 32),
                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      splashColor: Colors.white,

                      child: Text(
                        'Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'}',
                        style: TextStyle(fontSize: 20, color: Colors.white),

                      ),
                      onPressed: () {
                        setState(() {
                          _authMode =
                              _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ButtonTheme(
                    minWidth: 200,
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      onPressed: () => _submitForm(),
                      splashColor: Colors.white,
                      child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Signup',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/// This function may be used later. It adds "@csusm.edu" to the login
/// So users just need to type the first part of their school email
/*
    String validateEmail(String value) {
      if (value.isEmpty) {
        return 'Username cannot be empty';
        }

      RegExp exp = new RegExp(r"[a-z]{5}[0-9]{3}");

      if (!exp.hasMatch(value)) {
        return 'Enter a valid username';
      }
              
      return null;
    }
*/