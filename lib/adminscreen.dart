import 'package:flutter/material.dart';
import 'package:my_ole/loginscreen.dart';
import 'admin.dart';
import 'loginscreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';


double perpage = 1;

class AdminMainScreen extends StatefulWidget {
  final Admin admin;

  const AdminMainScreen({Key key,this.admin}) : super(key: key);
  

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  List data;
  GlobalKey<RefreshIndicatorState> refreshKey;
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  //Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _createDrawer(),
      appBar: AppBar(
        title: Text('Admin Page'),
      backgroundColor:  Colors.blue,

      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Text('List of Course',
              style: TextStyle(
                fontSize: 20.0,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Divider(thickness: 2.0,),
            /*ListView.builder(
                  //Step 6: Count the data
                  itemCount: data == null ? 1 : data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length && perpage > 1) {
                      return Container(
                        width: 250,
                        color: Colors.white,
                        child: MaterialButton(
                          child: Text(
                            "Load More",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      );
                    }
                    index -= 1;
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 2,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                  image: AssetImage('assets/images/job.png'
                                )))),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Container(
                                    margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            data[index]['jobtitle']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.person,
                                                ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                data[index]['jobowner']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.phone_android,
                                                ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                data[index]['jobphone']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(Icons.location_on,
                                                ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                data[index]['jobaddress']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //Text(data[index]['jobtime']),
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
                  }),*/
          ],
        ),
      ),
    );
  }

  /*Future<bool> _onBackPressAppBar() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
    return Future.value(false);
  }*/
  

  Widget _createDrawer(){
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createUserAccountHeader(),
            ListTile(
              leading: Icon(Icons.import_contacts),
              title: Text('Manage Course'),
              onTap: () {
                print("cliked");
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Page1(advertiser: advertiser)));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Manage Quiz'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
             ListTile(
              leading: Icon(Icons.person),
              title: Text('Trainee Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log out'),
              onTap: _gotologout,
            ),
          ],
        ),
      );
  }

  Widget _createUserAccountHeader(){
    return UserAccountsDrawerHeader(
      accountName: Text(widget.admin.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14, letterSpacing: 0.5)),
      accountEmail: Text(widget.admin.email,
      style: TextStyle(
   
        fontSize: 14, letterSpacing: 0.5)),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/admin.png'),
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
    );
  }
  void _gotologout() async {
    // flutter defined function
    print(widget.admin.name);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Log out?"),
          content: new Text("Are your sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () async {
                Navigator.of(context).pop();
                print("LOGOUT");
                Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}