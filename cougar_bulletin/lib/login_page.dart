import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget{
 LoginPage({this.auth, this.onSignedIn});
 final BaseAuth auth;
 final VoidCallback onSignedIn;

  @override 
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage>{
    
    final formKey = new GlobalKey<FormState>();
    
    String _email;
    String _password;
    FormType _formType = FormType.login;


/// This function will be used later. It adds "@csusm.edu" to the login
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
    bool validateAndSave(){
      final form = formKey.currentState;
      if (form.validate()){
        form.save();
        print('Email: $_email, password: $_password');
        return true;
      } else {
        print('form is invalid');
      }
      return false;
    }

    void validateAndSubmit() async {
      if (validateAndSave()){
        //_email = _email + "@cougars.csusm.edu";
        try {
          if (_formType == FormType.login) {
            String userId = await widget.auth.signInWithEmailAndPassword( _email, _password);
            print('Signed in: $userId');
          } else {
            String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
            print('Registered user: $userId');
          }
          widget.onSignedIn();
        }
        catch (e) {
          print('Error: $e');
        }
        
      }
    }

    void moveToRegister(){
      formKey.currentState.reset();
      setState(() {
            _formType = FormType.register;
      });
    }
    void moveToLogin() {
      setState(() {
            _formType = FormType.login;
      });      
    }

    @override
    Widget build(BuildContext context){
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Cougar Bulletin Login'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            ),
          )
        )
      );
    }

    List<Widget> buildInputs() {
      return [
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Email'),
          //maxLength: 8,
          validator:  (value) => value.isEmpty ? 'Email cannot be empty' : null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: new InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
          onSaved: (value) => _password = value,
        ),
      ];
    }

    List<Widget> buildSubmitButtons() {
      if (_formType == FormType.login) {
        return [
          new RaisedButton(
            child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          new FlatButton(
            child: new Text('Create an account', style: new TextStyle(fontSize:  20.0)),
            onPressed: moveToRegister,
          ),
        ];
      } else {
        return [
          new RaisedButton(
            child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
            onPressed: validateAndSubmit,
          ),
          new FlatButton(
            child: new Text('Have an account? Login', style: new TextStyle(fontSize:  20.0)),
            onPressed: moveToLogin,
          ),
        ];        
      }
    }
}