import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quest_2/data/userdata.dart';
import 'package:quest_2/initiate_app/forgot.dart';
import 'package:quest_2/models/user.dart';
import 'package:quest_2/initiate_app/signup.dart';
import 'package:quest_2/serviecs/user_types.dart';
import 'package:quest_2/staff/navigation_staff/navigation_staff.dart';
import 'package:quest_2/staff_manager/navigation_staffmanager/navigation_staffmanager.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;
import 'package:quest_2/user/navigation_user/navigation_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

bool? isvalid;
bool loginfail = false;
bool remembermecheck = false;
String usernameOnlogin = "";
String passOnlogin = "";

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    usernameOnlogin = "";
    passOnlogin = "";
    setState(() {});
    print("fetch 2 ");
  }

  void initState() {
    fectc();
    super.initState();
  }

  //API-Login Function//
  Future signIn(String username, String pass) async {
    String url =
        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/user_login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"Username": username, "Password": pass};
    var jsonResponse;

    var res = await http.post(Uri.parse(url), body: body);

    print(res.statusCode);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      setToken(jsonResponse['token']);
      print(jsonResponse['token']);
      print(jsonResponse['Usertype']);
      usertype = jsonResponse['Usertype'];

      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
      }
      print("opop2");

      sharedPreferences.setString('token', jsonResponse['token']);
      String urlProfile =
          "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/profile";
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Authorization': jsonResponse['token']
      };
      var resProfile = await http.get(
        Uri.parse(urlProfile),
        headers: requestHeaders,
      );
      print("opop");
      print(res.statusCode);
      print(resProfile);

      if (usertype == "User") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationUser()),
            (Route<dynamic> route) => false);
      } else if (usertype == "Staff") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationStaff()),
            (Route<dynamic> route) => false);
      } else if (usertype == "Staff_Manager") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationStaffmanager()),
            (Route<dynamic> route) => false);
      }

      if (resProfile.statusCode == 200) {
        print(json.decode(resProfile.body));
        UserData.userProfile =
            UserProfile.fromJson(json.decode(resProfile.body));
      }
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      // print("Response status; ${res.body}");
    }
    if (res.statusCode == 403) {
      setState(() {
        loginfail = true;
      });
      // print("Login fail");
    }
    if (res.statusCode == 404) {
      setState(() {
        loginfail = true;
      });
      // print("Login fail");
    }
    if (res.statusCode == 400) {
      setState(() {
        loginfail = true;
      });
      // print("Login fail");
    }
    if (res.statusCode == 401) {
      setState(() {
        loginfail = true;
      });
      // print("Login fail");
    }
  }

  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 166.66,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/quest_newlogo_color.png'), // Add Path image
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 70),
                  child: Text(
                    'Hello! Please login to your account.',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 50,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF6F2DA8),
                        ),
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Username',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        usernameOnlogin = val;
                        loginfail = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: Color(0xFF6F2DA8),
                        ),
                        errorText: loginfail
                            ? 'Your Username or Password was incorrect.'
                            : null,
                        errorStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        passOnlogin = val;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPage()));
                        print('Tap to Forgot your password');
                      },
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          color: Color(0xFF6F2DA8),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 20,
                ),
                MaterialButton(
                  color: Color(0xFF6F2DA8),
                  disabledColor: Colors.grey,
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed:
                      // usernameOnlogin != null ||
                      // passOnlogin != null
                      usernameOnlogin != "" && passOnlogin != ""
                          // usernameOnlogin != " " ||
                          // passOnlogin != " "
                          ? () {
                              signIn(usernameOnlogin, passOnlogin);
                            }
                          : null,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 33,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?  ",
                      style: TextStyle(color: Color(0xFFAEAEB2)),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          usernameOnlogin = " ";
                          passOnlogin = " ";
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()));

                        // print('tap');
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xFF6F2DA8),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
