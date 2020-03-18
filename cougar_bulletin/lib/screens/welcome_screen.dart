import 'package:flutter/material.dart';
import 'package:cougar_bulletin/screens/login_screen.dart';
import 'package:cougar_bulletin/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget{
  static String id = 'welcome screen';
  
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  AnimationController controller;

   @override
   void initState(){
     super.initState();

     controller = AnimationController(
       duration: Duration(seconds:1),
       vsync: this,
       upperBound: 60.0
     );

     controller.forward();
     controller.addListener(() {
       setState(() {
         
       });
       print(controller.value);
     });

   }
   
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
                Hero(
                  tag: 'logo',
                    child: Container(
                    child:Image.asset('images/logo.jpg'),
                    height:controller.value,
                  ),
                ),
                ColorizeAnimatedTextKit(
                  onTap: (){
                    print('Tap event');
                  },
                  text:['Cougar Bulletin'],
                  colors: [
                  Colors.redAccent,
                  Colors.blue,
                  Colors.yellow,
                  Colors.purple,
                  ],
                  textStyle: TextStyle(
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
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
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
                    Navigator.pushNamed(context, RegistrationScreen.id);
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