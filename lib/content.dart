import 'package:flutter/material.dart';
import 'user.dart';
import 'course.dart';

class CourseContent extends StatefulWidget {
  final User user;

 CourseContent({Key key,this.user}) : super(key: key);

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
       home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
     
        );
      
    
  }

}
    

