import 'package:flutter/material.dart';
import 'user.dart';
import 'course.dart';

class ManageCourse extends StatefulWidget {
  final User user;

 ManageCourse({Key key,this.user}) : super(key: key);

  @override
  _ManageCourseState createState() => _ManageCourseState();
}

class _ManageCourseState extends State<ManageCourse> {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
       home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Manage Course'),
        ),
        body: Center(
          child: Container(
            
          ),
        ),
      ),
     
        );
      
    
  }

}