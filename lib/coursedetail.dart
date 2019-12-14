import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_ole/content.dart';
import 'user.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'course.dart';
import 'mainscreen.dart';

class CourseDetail extends StatefulWidget {
  final Course course;
  final User user;

  const CourseDetail({Key key, this.course, this.user}) : super(key: key);

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text(widget.course.coursename),
            backgroundColor: Colors.blue,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                course: widget.course,
                user: widget.user,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            user: widget.user,
          ),
        ));
    return Future.value(false);
  }
}

class DetailInterface extends StatefulWidget {
  final Course course;
  final User user;
  DetailInterface({this.course, this.user});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(),
        Container(
          height: 100,
          child: Image.network(
              'http://myondb.com/oleproject/images/${widget.course.courseimage}.png',
              fit: BoxFit.fitWidth),
        ),
        SizedBox(height: 10),
        Text(widget.course.coursename,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              //margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(2.0))),
              child: Text("About \n" + widget.course.coursedes + "\n\nDuration: " + widget.course.courseduration,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15, letterSpacing: 0.6,height: 1.5,
                      color: Colors.blueGrey)),
            ),
              SizedBox(height: 15),
              Container(
                width: 200,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  height: 50,
                  child: Text(
                    'Enroll Course',
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Colors.blue[700],
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: _onEnroll,
                ),
              ),
            ],
          );
  }

  void _onEnroll(){
    if (widget.user.email == "user@noregister"){

    }else{
      _showDialog();
    }
    print("Enroll Course");
  }

  void _showDialog(){
    //flutter defined function
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enroll course of " + widget.course.coursename),
        content: Text("Are you sure?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Yes"),
            onPressed: (){
               Navigator.of(context).pop();
                enrollCourse();
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
        );
    },
    );
  }

  Future<String> enrollCourse() async {
    String urlCourse = "http://myondb.com/oleproject/php/enroll_course.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
        pr.style(message: "Enroll Course");
        pr.show();
        http.post(urlCourse, body: {
          "courseid": widget.course.courseid,
          "email": widget.user.email,
        }).then((res) {
          if (res.body == "success"){
            Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
            _onLogin(widget.user.email, context);
          }else {
            Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
          }
        }).catchError((err) {
          print(err);
          pr.dismiss();
        });
        return null;
  }
   void _onLogin(String email, BuildContext ctx) {
     String urlgetuser = "http://myondb.com/oleproject/php/get_user.php";

    http.post(urlgetuser, body: {
      "email": email,
    }).then((res) {
      print(res.statusCode);
      var string = res.body;
      List dres = string.split(",");
      print(dres);
      if (dres[0] == "success") {
        User user = new User(
            name: dres[1],
            email: dres[2],
            phone: dres[3],
            dob: dres[4],
            address: dres[5]);
        Navigator.push(ctx,
            MaterialPageRoute(builder: (context) => CourseContent(user: user)));
      }
    }).catchError((err) {
      print(err);
    });
  }
    
}
