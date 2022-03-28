import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/rewarddetail.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/confirm_reward_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_user/navigation_user.dart';

bool saveto = false;

Future sendaddress(String id, String address, bool save) async {
  print("checkoue reward activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/send_reward_address_detail";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };

  Map body = {
    "Reward_ID": id,
    "SHIPPING_Address": address,
    "SHIPPING_Save_User": save,
  };

  print(body);

  final jsonbody = jsonEncode(body);
  var jsonResponse;
  var res =
      await http.post(Uri.parse(url), headers: requestHeaders, body: jsonbody);
  if (res.statusCode == 201) {
    return jsonResponse;
  }
}

class CheckOutRewardUserPage extends StatefulWidget {
  CheckOutRewardUserPage({Key? key}) : super(key: key);

  @override
  State<CheckOutRewardUserPage> createState() => _CheckOutRewardUserPageState();
}

class _CheckOutRewardUserPageState extends State<CheckOutRewardUserPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Reward',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF6F2DA8),
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0.0,
          leading: BackButton(
            color: Color(0xFF6F2DA8),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(context: context) / 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height(context: context) / 9,
              ),
              SizedBox(
                height: height(context: context) / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    rewardDetailData.rewardDetail!.rewardName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: height(context: context) / 100,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${rewardDetailData.rewardDetail!.rewardImage}"),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: height(context: context) / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                decoration: BoxDecoration(
                    color: Color(0xFFf0eff5),
                    borderRadius: new BorderRadius.all(Radius.circular(8.0))),
                child: Row(
                  children: [
                    Text(
                      rewardDetailData.rewardDetail!.rewardPrice.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      '  Points',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height(context: context) / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Address for shiping",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFf0eff5),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          addresspayload!,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height(context: context) / 475,
              ),
              Row(
                children: [
                  Checkbox(
                      activeColor: Color(0xFF6F2DA8),
                      value: saveto,
                      onChanged: (val) {
                        setState(() {
                          saveto = val!;
                        });
                        print(val);
                      }),
                  Text(
                    'save address',
                    style: TextStyle(
                      color: Color(0xFF6F2DA8),
                    ),
                  ),
                ],
              ),
//=====Button Function========================================================//
              SizedBox(
                height: height(context: context) / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(8.0), child: checkoutButton()),
                ],
              ),
              SizedBox(
                height: height(context: context) / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkoutButton() {
    return MaterialButton(
      color: Color(0xFF6F2DA8),
      disabledColor: Colors.grey,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        final rewardid = prefs.getString('selectrewardid');

        sendaddress(rewardid!, addresspayload!, saveto);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => NavigationUser()),
            (Route<dynamic> route) => false);
      },
      child: Text(
        "Check Out",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
