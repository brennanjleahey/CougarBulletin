import 'package:cougar_bulletin/api/post_api.dart';
import 'package:cougar_bulletin/feed_page.dart';
import 'package:cougar_bulletin/model/user.dart';
import 'package:cougar_bulletin/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cougar_bulletin/components/RoundedButton.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  static const String id = 'Login_screen';
 @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  //AuthMode _authMode = AuthMode.Login;

  User _user = User();

  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {return;}
    _formKey.currentState.save();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  }


  Widget build(BuildContext context){
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: ListView(
              children:<Widget> [Padding(
          padding:EdgeInsets.symmetric(horizontal: 24.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                  child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.jpg'),
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              
              TextFormField( 
                autovalidate: true,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                validator: (String value) {
                  if (value.isEmpty) {
                  return 'Email is required';
                  }

                  if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
                  return 'Please enter a valid email address';
                  }
                return null;
                },

              onSaved: (String value) {
                 _user.email = value;
              },
              decoration: InputDecoration(
               hintText: 'Enter your email',
              hintStyle: TextStyle(fontSize: 20.0,color: Colors.black.withOpacity(0.2)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                   enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
               SizedBox(
                height: 8.0,
              ),
              TextFormField(
                autovalidate: true,
                obscureText: true,
                textAlign: TextAlign.center,
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
                 decoration: InputDecoration(
                    hintText: 'Enter your password.',
                    hintStyle: TextStyle(fontSize: 20.0,color: Colors.black.withOpacity(0.2)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                 ),
              ),
              SizedBox(
                height: 20.0,
              ),
               RoundedButton(
                 title: 'Log In',
                 colour: Colors.blueAccent,
                 onPressed: () => _submitForm(),
              ),
            ],
          ),
        )
              ],
      ),
    
    
    );

  }
}