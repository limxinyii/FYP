import 'package:flutter/material.dart';
import 'user.dart';


double perpage = 1;

class TabScreen2 extends StatefulWidget {
  final User user;

  TabScreen2({Key key, this.user});

  @override
  _TabScreen2State createState() => _TabScreen2State();
}
 
class _TabScreen2State extends State<TabScreen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('tab 2'),
          ),
        ),
      ),
    );
  }
}