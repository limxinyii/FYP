import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'user.dart';

String urlgetuser = "";
String urluploadImage = "";
String urlupdate = "";
File _image;
int number = 0;
String _value;


class TabScreen3 extends StatefulWidget {
  final User user;
  TabScreen3({Key key, this.user});

  @override
  _TabScreen3State createState() => _TabScreen3State();
}
 
class _TabScreen3State extends State<TabScreen3> {
  GlobalKey<RefreshIndicatorState> refreshKey;

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
        body: ListView.builder(
          // count the data
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Image.asset(
                        "assets/images/skystar.png",
                        fit: BoxFit.fitWidth,
                      ),

                    ],)
                  ],),
              );
            }
          }

        )
       
      ),
    );
  }
}