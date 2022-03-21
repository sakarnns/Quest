import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/initiate_app/verifyOTP.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

Future forgetpass(String email) async {
  print("forget password activate!");
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/forget_password";

  Map body = {"email": email};

  var res = await http.post(Uri.parse(url), body: body);

  if (res.statusCode == 200) {
    print("mail sent");
  }
}

class ForgotPage extends StatefulWidget {
  ForgotPage({Key? key}) : super(key: key);

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

String? emailaddress;
bool? isvalid;
bool remembermecheck = false;

class _ForgotPageState extends State<ForgotPage> {
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
                      top: MediaQuery.of(context).size.height / 33),
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                  child: Text(
                    'Enter the email address associated with your account.',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context: context) / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height(context: context) / 50,
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorText: isvalid == null
                              ? null
                              : isvalid!
                                  ? null
                                  : "Please enter a valid email",
                          focusedBorder: outlineInputBorder(),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'E-mail',
                          contentPadding: EdgeInsets.all(8.0),
                          border: outlineInputBorder()),
                      onChanged: (val) {
                        if (val.isEmpty ||
                            EmailValidator.validate(
                              val,
                            )) {
                          setState(() {
                            emailaddress = val;
                            isvalid = true;
                          });
                        } else {
                          setState(() {
                            emailaddress = val;
                            isvalid = false;
                          });
                        }

                        // print(isvalid);
                      }),
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
                  onPressed: isvalid != false &&
                          emailaddress != null &&
                          emailaddress != "" &&
                          emailaddress != " "
                      ? () {
                          forgetpass(emailaddress!);
                          print(emailaddress);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyOTP()),
                          );
                        }
                      : null,
                  child: Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//  forgetpass(emailaddress!);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => VerifyOTP()),
//                   );
