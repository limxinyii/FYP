import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user.dart';

class ManageProfile extends StatefulWidget {
  final User user;

  ManageProfile({Key key, this.user}) : super(key: key);

  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List data;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: Text('Trainee Profile'),
          ),
          
          body:
          Card(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/u1.jpg'),
                minRadius: 40,
                maxRadius: 50,
              ),
              SizedBox(height: 15),
              Container(
                child: Center(
                  child: Text("LIM \n xinyi1022@hotmail.com",
                  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8)),
                ),
              ),
              SizedBox(height: 20),
                CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/u2.jpg'),
                minRadius: 40,
                maxRadius: 50,
              ),
              SizedBox(height: 15),
              Container(
                child: Center(
                  child: Text("FUN \n happyfun@hotmail.com",
                  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8)),
                ),
              ),
                  SizedBox(height: 20),
                CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/u2.jpg'),
                minRadius: 40,
                maxRadius: 50,
              ),
              SizedBox(height: 15),
              Container(
                child: Center(
                  child: Text("SITI ANA \n abc12@hotmail.com",
                  textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8)),
                ),
              ),
            ],
            
          ))),
    );
  }
}
