import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_ole/loginscreen.dart';

//import 'loginscreen.dart';

void main() => runApp(SplashScreen());
 
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
    return MaterialApp(
       theme: new ThemeData(
        primaryColor: Colors.lightBlueAccent,
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.lightBlue,
       ),
      debugShowCheckedModeBanner: false, 
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/ole.png',
                width: 280,
                height: 280,
              ),
              SizedBox(
                height: 20,
              ),
              new ProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
} 

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
} 

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
        animation = Tween(begin: 0.0, end: 1.0).animate(controller) 
        ..addListener(() {
          setState(() {
            if (animation.value > 0.99){
              //Nagivation to new page is here 
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()
                   ));
            }
          });
        });
        controller.repeat();
  }
  
  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
          //color: Colors.blueAccent,
          child: CircularProgressIndicator(
           // value: animation.value,
            //backgroundColor: Colors.black,
            //valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          ),
    ));
  }
}