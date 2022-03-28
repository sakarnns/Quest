import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/login.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quest_2/initiate_app/terms_condition.dart';

// import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
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

class _SignupPageState extends State<SignupPage> {
  //API-SignUP Function//
  Future signUp(String username, String firstname, String lastname,
      String email, String pass) async {
    String url =
        "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/create_user";
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(usernameOnSignup);
    Map body = {
      "Username": username,
      "Name": firstname,
      "Surname": lastname,
      "Email": email,
      "Password": pass
    };
    var jsonResponse;

    var res = await http.post(Uri.parse(url), body: body);
    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print("Response status; ${res.statusCode}");
      // print("Response status; ${res.body}");
      return jsonResponse;
    } else {}
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
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                usernameOnSignup = "";
                firstnameOnSignup = "";
                lastnameOnSignup = "";
                emailOnSignup = "";
                passOnSignup = "";
                confirmpassOnSignup = "";
                agreedterm = false;
              });
            },
          ),
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
                      top: MediaQuery.of(context).size.height / 70),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 100),
                  child: Text(
                    'Create your account.',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w200,
                    ),
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
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF6F2DA8),
                        ),
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Firstname',
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
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF6F2DA8),
                        ),
                        focusedBorder: outlineInputBorder(),
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: 'Lastname',
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
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Color(0xFF6F2DA8),
                          ),
                          errorText: isvalid == null || emailOnSignup == ""
                              ? null
                              : isvalid!
                                  ? null
                                  : "Please enter a valid Email",
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
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: Color(0xFF6F2DA8),
                        ),
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
                        prefixIcon: Icon(
                          Icons.vpn_key_rounded,
                          color: Color(0xFF6F2DA8),
                        ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: agreedterm,
                            activeColor: Color(0xFF6F2DA8),
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
                  color: Color(0xFF6F2DA8),
                  disabledColor: Colors.grey,
                  minWidth: 163,
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: usernameOnSignup != null &&
                          usernameOnSignup != "" &&
                          usernameOnSignup != " " &&
                          firstnameOnSignup != null &&
                          firstnameOnSignup != "" &&
                          firstnameOnSignup != " " &&
                          lastnameOnSignup != null &&
                          lastnameOnSignup != "" &&
                          lastnameOnSignup != " " &&
                          emailOnSignup != null &&
                          emailOnSignup != "" &&
                          emailOnSignup != " " &&
                          isvalid != false &&
                          isPasswordMatch != null &&
                          isPasswordMatch! &&
                          passOnSignup != "" &&
                          passOnSignup != " " &&
                          agreedterm != false
                      ? () {
                          signUp(usernameOnSignup!, firstnameOnSignup!,
                              lastnameOnSignup!, emailOnSignup!, passOnSignup!);

                          usernameOnSignup = "";
                          firstnameOnSignup = "";
                          lastnameOnSignup = "";
                          emailOnSignup = "";
                          passOnSignup = "";
                          confirmpassOnSignup = "";
                          agreedterm = false;

                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      : null,
                  child: Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already an account? ",
                      style: TextStyle(color: Color(0xFFAEAEB2)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF6F2DA8),
                        ),
                      ),
                    )
                  ],
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
