import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quest_2/initiate_app/terms_condition.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_staffmanager/navigation_staffmanager.dart';

Future createstaff(String username, String firstname, String lastname,
    String email, String pass) async {
  final prefs = await SharedPreferences.getInstance();
  final val = prefs.getString('token');
  print("createstaff activated");

  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/create_staff";
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  Map body = {
    "Username": username,
    "Name": firstname,
    "Surname": lastname,
    "Email": email,
    "Password": pass
  };
  var jsonResponse;

  var res = await http.post(Uri.parse(url),
      headers: requestHeaders, body: json.encode(body));
  print("=============");
  print(res.statusCode);
  print(res.body);
  print("===============");

  if (res.statusCode == 201) {
    jsonResponse = json.decode(res.body);
    print("Response status; ${res.statusCode}");
    // print("Response status; ${res.body}");
    return jsonResponse;
  }
}

class CreateStaffManagerPage extends StatefulWidget {
  CreateStaffManagerPage({Key? key}) : super(key: key);

  @override
  State<CreateStaffManagerPage> createState() => _CreateStaffManagerPageState();
}

bool? isvalid;
bool agreedterm = false;
String? usernameOnSignup;
String? firstnameOnSignup;
String? lastnameOnSignup;
String? emailOnSignup;
String? confirmpassOnSignup;
String? passOnSignup;
bool? isPasswordMatch;

class _CreateStaffManagerPageState extends State<CreateStaffManagerPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Staff',
              style: TextStyle(fontSize: 28, color: Colors.black)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          backgroundColor: Color(0xFFEBEDF2),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height(context: context) / 20,
                ),
                Container(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    'assets/icons/create_staff.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                  child: Text(
                    'Create account for Staff',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFF6F2DA8)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'First Name',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        firstnameOnSignup = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Last Name',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        lastnameOnSignup = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorText: isvalid == null || emailOnSignup == ""
                              ? null
                              : isvalid!
                                  ? null
                                  : "Please enter a valid email",
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Email',
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        emailOnSignup = val;

                        if (emailOnSignup == null ||
                            EmailValidator.validate(
                              emailOnSignup!,
                            )) {
                          setState(() {
                            isvalid = true;
                          });
                        } else {
                          setState(() {
                            isvalid = false;
                          });
                        }

                        // print(isvalid);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 130,
                  ),
                  child: TextField(
                    obscureText: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Username',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        usernameOnSignup = val;
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
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Password',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        passOnSignup = val;
                        if (passOnSignup == confirmpassOnSignup) {
                          isPasswordMatch = true;
                        } else {
                          isPasswordMatch = false;
                        }
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
                        errorText: isPasswordMatch == null || isPasswordMatch!
                            ? null
                            : 'Mismatched Password',
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Confirm Password',
                        contentPadding: EdgeInsets.all(8.0),
                        border: outlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        confirmpassOnSignup = val;
                        if (passOnSignup == confirmpassOnSignup) {
                          isPasswordMatch = true;
                        } else {
                          isPasswordMatch = false;
                        }
                      });

                      print(isPasswordMatch);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: agreedterm,
                            onChanged: (val) {
                              setState(() {
                                agreedterm = val!;
                              });
                              print(val);
                            }),
                        Text('I have read and agreed with '),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermsAndConditionPage()));
                          },
                          child: Text(
                            "terms and conditions",
                            style: TextStyle(
                              color: Color(0xFF6F2DA8),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                MaterialButton(
                  color: Colors.black,
                  disabledColor: Colors.grey,
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: usernameOnSignup != null &&
                          usernameOnSignup != "" &&
                          firstnameOnSignup != null &&
                          firstnameOnSignup != "" &&
                          lastnameOnSignup != null &&
                          lastnameOnSignup != "" &&
                          emailOnSignup != null &&
                          emailOnSignup != "" &&
                          isPasswordMatch != null &&
                          isPasswordMatch! &&
                          agreedterm != false &&
                          passOnSignup != ""
                      ? () {
                          print(usernameOnSignup);
                          print(firstnameOnSignup!);
                          print(lastnameOnSignup!);
                          print(emailOnSignup!);
                          print(passOnSignup!);
                          createstaff(usernameOnSignup!, firstnameOnSignup!,
                              lastnameOnSignup!, emailOnSignup!, passOnSignup!);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NavigationStaffmanager()),
                              (Route<dynamic> route) => false);
                        }
                      : null,
                  child: Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 50,
                ),
                SizedBox(
                  height: height(context: context) / 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
