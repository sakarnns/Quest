import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quest_2/data/rewarddetail.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkout_reward_user.dart';

int? tokenexpire;

Future getsavedaddress() async {
  print("getsaved activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/get_save_address";
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': (val) as String
  };
  var jsonResponse;
  var res = await http.get(
    Uri.parse(url),
    headers: requestHeaders,
  );

  tokenexpire = res.statusCode;
  print(res.statusCode);

  if (res.statusCode == 200) {
    print(json.decode(res.body));
    var resdecode = json.decode(res.body);
    if (resdecode['Address'] == "") {
      savedaddr = "nodata";
    } else {
      savedaddr = resdecode['Address'];
    }

    return jsonResponse;
  }
}

class ConfirmRewardUserPage extends StatefulWidget {
  ConfirmRewardUserPage({Key? key}) : super(key: key);

  @override
  State<ConfirmRewardUserPage> createState() => _ConfirmRewardUserPageState();
}

String? rewardhousenocheck;
String? rewardstreetcheck;
String? rewardsubdistrictcheck;
String? rewarddistrictcheck;
String? rewardprovincecheck;
String? rewardpostalcodecheck;
String rewardotherdetailscheck = "";
String? savedaddr;
String? addresspayload;

class _ConfirmRewardUserPageState extends State<ConfirmRewardUserPage> {
  int _value = 1;
  bool isVisibleone = true;
  bool isVisibletwo = false;

  void initState() {
    fectc();

    super.initState();
  }

  void fectc() async {
    print("fetch 1 ");
    await getsavedaddress();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    setState(() {});
    print(savedaddr);
    print("fetch 2 ");
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
            title: Text('Reward',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16))),
            // backgroundColor: Colors.transparent,
            backgroundColor: Color(0xFFEBEDF2),
            elevation: 0.0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(context: context) / 20,
              ),
              child: Column(
                children: [
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
                        borderRadius: new BorderRadius.only(
                          // bottomLeft: const Radius.circular(8.0),
                          // bottomRight: const Radius.circular(8.0),
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/${rewardDetailData.rewardDetail!.rewardImage}"),
                            fit: BoxFit.cover)),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFE5E5EA),
                            borderRadius: new BorderRadius.only(
                              bottomLeft: const Radius.circular(8.0),
                              bottomRight: const Radius.circular(8.0),
                            )),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 64,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Valid Date ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  rewardDetailData.rewardDetail!.rewardEndDate
                                      .toIso8601String()
                                      .replaceAll("T", " ")
                                      .substring(0, 19),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Color(0xFFD1D1D6),
                              thickness: 1,
                              endIndent: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Remain ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  rewardDetailData.rewardDetail!.rewardRemain
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                        color: Color(0xFFE5E5EA),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(8.0))),
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
                              fontWeight: FontWeight.w700),
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
                        "Reward Detail",
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
                        height: 172,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFE5E5EA),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8.0))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              rewardDetailData.rewardDetail!.rewardDetail,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height(context: context) / 25,
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
                  selectedAddress(),
                  widgetnewadress(),
                  widgetoldadress(),
                ],
              ),
            ),
          )),
    );
  }

  Widget selectedAddress() {
    return Container(
      child: Row(
        children: [
          Radio<int>(
            value: 0,
            groupValue: _value,
            onChanged: (value) {
              setState(
                () {
                  if (savedaddr == "nodata") {
                    value = 0;

                    isVisibleone = true;
                    isVisibletwo = false;
                  } else {
                    _value = value!.toInt();

                    isVisibleone = false;
                    isVisibletwo = true;

                    rewardhousenocheck = "";
                    rewardstreetcheck = "";
                    rewardsubdistrictcheck = "";
                    rewarddistrictcheck = "";
                    rewardprovincecheck = "";
                    rewardpostalcodecheck = "";
                  }
                },
              );
            },
            activeColor: Colors.black,
            toggleable: true,
          ),
          Text("Saved Address"),
          Radio<int>(
            value: 1,
            groupValue: _value,
            onChanged: (value) {
              setState(() {
                _value = value!.toInt();
                isVisibletwo = false;
                isVisibleone = true;

                rewardhousenocheck = "";
                rewardstreetcheck = "";
                rewardsubdistrictcheck = "";
                rewarddistrictcheck = "";
                rewardprovincecheck = "";
                rewardpostalcodecheck = "";
              });
            },
            activeColor: Colors.black,
            toggleable: true,
          ),
          Text("New Address"),
        ],
      ),
    );
  }

  Widget widgetoldadress() {
    return Visibility(
      visible: isVisibletwo,
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 16.0),
              decoration: BoxDecoration(
                  color: Color(0xFFE5E5EA),
                  borderRadius: new BorderRadius.all(Radius.circular(8.0))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    savedaddr!,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 220, bottom: 48),
                    child: confirmButtonolddress()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetnewadress() {
    return Visibility(
      visible: isVisibleone,
      child: Container(
        child: Column(
          children: [
// =====House No., Apt, Bldg===================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "House No., Apt, Bldg",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewardhousenocheck = val;
                  });
                },
              ),
            ),
//=====Street=================================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Street",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewardstreetcheck = val;
                  });
                },
              ),
            ),
//=====Subdistrict=================================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Subdistrict",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewardsubdistrictcheck = val;
                  });
                },
              ),
            ),
//=====District=================================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "District",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
                // minLines: 3,
                // maxLines: null,
                // maxLength: 35,
                // controller: activity.eventdetial,
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewarddistrictcheck = val;
                  });
                },
              ),
            ),
//=====Province=================================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Province",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                inputFormatters: [LengthLimitingTextInputFormatter(35)],
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewardprovincecheck = val;
                  });
                },
              ),
            ),
//=====Postal Code=================================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Postal Code",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [LengthLimitingTextInputFormatter(5)],
                // controller: activity.eventdetial,
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewardpostalcodecheck = val;
                  });
                },
              ),
            ),
//=====Other Details=================================================================//
            SizedBox(
              height: height(context: context) / 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Other Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height(context: context) / 500,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 3,
                maxLength: 60,
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder(),
                  filled: true,
                  fillColor: Color(0xFFE5E5EA),
                  contentPadding: EdgeInsets.all(8.0),
                  border: outlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    rewardotherdetailscheck = val;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 48),
                    child: confirmButtonnewdress()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmButtonnewdress() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: rewardhousenocheck != null &&
              rewardhousenocheck != "" &&
              rewardstreetcheck != null &&
              rewardstreetcheck != "" &&
              rewardsubdistrictcheck != null &&
              rewardsubdistrictcheck != "" &&
              rewarddistrictcheck != null &&
              rewarddistrictcheck != "" &&
              rewardprovincecheck != null &&
              rewardprovincecheck != "" &&
              rewardpostalcodecheck != null &&
              rewardpostalcodecheck != ""
          ? () {
              print(rewardhousenocheck);
              print(rewardstreetcheck);
              print(rewardsubdistrictcheck);
              print(rewarddistrictcheck);
              print(rewardprovincecheck);
              print(rewardpostalcodecheck);
              print(rewardotherdetailscheck);
              addresspayload = (rewardhousenocheck! +
                  " " +
                  rewardstreetcheck! +
                  " " +
                  rewardsubdistrictcheck! +
                  " " +
                  rewardprovincecheck! +
                  " " +
                  rewardprovincecheck! +
                  " " +
                  rewardpostalcodecheck! +
                  " " +
                  rewardotherdetailscheck);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOutRewardUserPage()));
            }
          : null,
      child: Text(
        "Next",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget confirmButtonolddress() {
    return MaterialButton(
      disabledColor: Colors.grey,
      color: Colors.black,
      minWidth: 150,
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        addresspayload = savedaddr;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CheckOutRewardUserPage()));
      },
      child: Text(
        "Next",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
