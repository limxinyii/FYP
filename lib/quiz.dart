import 'package:flutter/material.dart';
import 'user.dart';
import 'course.dart';

class QuizScreen extends StatefulWidget {
  final User user;

 QuizScreen({Key key,this.user}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
       home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Manage Quiz'),
        ),
        body: Center(
          child: Container(
          
          ),
        ),
      ),
     
        );
      
    
  }

}