import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget{
  static String id = 'welcome screen';
  
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal:64.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget>[
            Row(
              children:<Widget>[
                Container(
                  child:Image.asset('images/logo.jpg'),
                  height:60.0,
                ),
                Text('Cougar Bulletin',
                  style: TextStyle(
                    fontSize:30.0,
                    fontWeight:FontWeight.bold,
                    color: Colors.black54
                  ),)
              ]
            ),
            SizedBox(
              height:48.0
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation:5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                  },
                   minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                )
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation:5.0,
                child:MaterialButton(
                  onPressed: (){
                    //Go to registration screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                )
                
              ),
            )
          ]
        ), ),
      
    ) ;
  }

}