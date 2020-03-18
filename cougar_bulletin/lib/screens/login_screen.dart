import 'package:flutter/material.dart';
import 'package:cougar_bulletin/components/RoundedButton.dart';

class LoginScreen extends StatefulWidget{
  static const String id = 'Login_screen';
  
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  
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
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
              decoration: InputDecoration(
                hintText: 'Enter your email',
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
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                 decoration: InputDecoration(
                    hintText: 'Enter your password.',
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
               RoundedButton(title: 'Log In',colour: Colors.blueAccent,onPressed:(){})
            ],
          ),
        )
              ],
      ),
    
    
    );

  }
}