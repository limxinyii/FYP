import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'adminscreen.dart';
import 'package:my_ole/forgotpassscreen.dart';
import 'package:my_ole/mainscreen.dart';
import 'forgotpassscreen.dart';
import 'mainscreen.dart';
import 'registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'admin.dart';

String urlLogin = "http://myondb.com/oleproject/php/login.php";
String urlLoginAdmin ="http://myondb.com/oleproject/php/login_admin.php";
final TextEditingController _emcontroller = TextEditingController();
String _email = "";
final TextEditingController _passcontroller = TextEditingController();
String _password = "";
bool _isChecked = false;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _globalKey = new GlobalKey();
  bool _autoValidate = false;
  bool _isChecked = false;
  //var role = ['Select Role', 'Admin', 'User'];
  //var role_selected = 'Select Role';

  @override
  void initState() {
    loadpref();
    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return WillPopScope(
        onWillPop: _onBackPressAppBar,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: new Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/ole.png',
                  scale: 3.0,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: _emcontroller,
                    autovalidate: _autoValidate,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ))),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passcontroller,
                  autovalidate: _autoValidate,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                       border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent))),
                  obscureText: true,
                ),
               /* Row(
                  children: <Widget>[
                    DropdownButton<String>(
                      items: role.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this.role_selected = newValueSelected;
                        });
                      },
                      value: role_selected,
                    ),
                  ],
                ),*/
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool value) {
                        _onChange(value);
                      },
                    ),
                    Text('Remember Me', style: TextStyle(fontSize: 15))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                 Text('Login as: ', style: TextStyle(fontSize: 15,
                 letterSpacing: 0.8)),
                 SizedBox(
                  height: 15,
                ),
                Container(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                   MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: 120,
                  height: 50,
                  child: Text(
                    'Admin',
                    style: TextStyle(fontSize: 18, letterSpacing: 0.8),
                  ),
                  color: Colors.blue[700],
                  textColor: Colors.white,
                  //elevation: 15,
                  onPressed: _onLoginAdmin,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  minWidth: 120,
                  height: 50,
                  child: Text(
                    'User',
                    style: TextStyle(fontSize: 18, letterSpacing: 0.8),
                  ),
                  color: Colors.blue[700],
                  textColor: Colors.white,
                  //elevation: 15,
                  onPressed: _onLogin,
                ),
                ],
                ),),
               
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _onRegister,
                  child: Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _onForget,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String _validateEmail(String value) {
    // The form is empty
    if (value.length == 0) {
      return "Please enter your email";
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }

  String _validatePassword(String value) {
    if (value.length == 0) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password must at least 6 characters";
    } else {
      return null;
    }
  }

  void _onLoginAdmin() {
    _email = _emcontroller.text;
    _password = _passcontroller.text;

    if (_isEmailValid(_email) && (_password.length > 5)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Login In");
      pr.show();
      http.post(urlLoginAdmin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
        var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "Login Successful") {
          pr.dismiss();
          // print("Radius:");
          print(dres);
          Admin admin = new Admin(name: dres[1], email: dres[2]);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminMainScreen(admin: admin)));
        } else {
          pr.dismiss();
        }
      }).catchError((error) {
        pr.dismiss();
        print(error);
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }


  void _onLogin() {
    _email = _emcontroller.text;
    _password = _passcontroller.text;

    if (_isEmailValid(_email) && (_password.length > 5)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Login In");
      pr.show();
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
        var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "Login Successful") {
          pr.dismiss();
          // print("Radius:");
          print(dres);
          User user = new User(name: dres[1], email: dres[2], phone: dres[3], dob: dres[4], address: dres[5]);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainScreen(user: user)));
        } else {
          pr.dismiss();
        }
      }).catchError((error) {
        pr.dismiss();
        print(error);
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _onRegister() {
    //print('onRegister');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }

  void _onForget() {
    print('Forgot password');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      savepref(value);
    });
  }

  void loadpref() async {
    print('Inside loadpref()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    _password = (prefs.getString('pass'));
    print(_email);
    print(_password);
    if (_email.length > 1) {
      _emcontroller.text = _email;
      _passcontroller.text = _password;
      setState(() {
        _isChecked = true;
      });
    } else {
      print('No pref');
      setState(() {
        _isChecked = false;
      });
    }
  }

  void savepref(bool value) async {
    print('Inside savepref');
    _email = _emcontroller.text;
    _password = _passcontroller.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save pref
      if (_isEmailValid(_email) && (_password.length > 5)) {
        await prefs.setString('email', _email);
        await prefs.setString('pass', _password);
        print('Save pref $_email');
        print('Save pref $_password');
        Toast.show("Preferences have been saved", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        print('No email');
        setState(() {
          _isChecked = false;
        });
        Toast.show("Check your credentials", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emcontroller.text = '';
        _passcontroller.text = '';
        _isChecked = false;
      });
      print('Remove pref');
      Toast.show("Preferences have been removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
