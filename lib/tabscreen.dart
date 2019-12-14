import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'course.dart';
import 'user.dart';
import 'coursedetail.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'SlideRightRoute.dart';

double perpage = 1;

class TabScreen extends StatefulWidget {
  final User user;
  //final Course course;

  TabScreen ({Key key, this.user});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
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
            title: Text(
              "Online Training Everywhere (OLE)",
              style: TextStyle(color: Colors.white),
            ),
          ),
          
          body: RefreshIndicator(
            key: refreshKey,
            color: Colors.blue,
            onRefresh: () async {
              await refreshList();
            },
            child: ListView.builder(
                //step 6: Count the data
                itemCount: data == null ? 1 : data.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                        child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Stack(
                          children: <Widget>[
                            Container(
                              //height: 50,
                           // color: Colors.blue,
                            child: Center(
                              child:  Text("Course Enroll",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent, letterSpacing: 0.8)),
                            ),
                            ),
                          ],
                        ),
                      ],
                    ));
                  }
                  if (index == data.length && perpage > 1) {
                    return Container(
                      width: 250,
                      color: Colors.white,
                      child: MaterialButton(
                        child: Text("Load More",
                        style: TextStyle(color: Colors.black),
                        ),
                        onPressed: (){},
                        ),
                    );
                  }
                  index -=1;
                  return Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Card(
                      elevation: 2,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape:BoxShape.circle,
                                  border: Border.all(color: Colors.blueGrey),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      "http://myondb.com/oleproject/images/${data[index]['courseimage']}.png"
                                      )))),
                                      Expanded(
                                        child: Container(
                                          child: Column(children: <Widget>[
                                            Text(
                                              data[index]['coursename']
                                            .toString(),
                                            style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold)),
                                               SizedBox(
                                          height: 5,
                                        ),
                                        Text("Duration: " + data[index]['courseduration']),
                                          ],
                                          ),
                                        ),
                                        ),
                            ],
                            ),
                          ),
                      ),
                      ),
                      );
                }),
          )),
    );
  }

  Future<String> makeRequest() async {
    String urlCourse = "http://myondb.com/oleproject/php/load_enrolled_course.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    pr.show();
    http.post(urlCourse, body: {
      "email": widget.user.email ?? "notavail",
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["course"];
        perpage = (data.length / 10);
        print("data");
        print(data);
        pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }
   Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.makeRequest();
    return null;
  }
}