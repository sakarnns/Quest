import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/data/transactions.dart';
import 'package:quest_2/models/transactions.dart';
import 'package:quest_2/styles/size.dart';
import 'package:quest_2/user/timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

bool isLoading = true;
int? tokenexpire;

Future transaction() async {
  print("transaction activate!");
  final prefs = await SharedPreferences.getInstance();

  final val = prefs.getString('token');
  String url =
      "http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/transaction";
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

    List data = json.decode(res.body);

    transactionsData.transactions =
        data.map((p) => Transactions.fromJson(p)).toList();

    // print("transactions ${transactionsData.transactions}");

    jsonResponse = json.decode(res.body);
    print("Response status: ${res.statusCode}");
    return jsonResponse;
  } else {}
}

class LogTransactionPage extends StatefulWidget {
  LogTransactionPage({Key? key}) : super(key: key);

  @override
  _LogTransactionPageState createState() => _LogTransactionPageState();
}

class _LogTransactionPageState extends State<LogTransactionPage> {
  @override
  void initState() {
    fectc();
    super.initState();
  }

  void fectc() async {
    isLoading = true;
    print("fetch 1 ");
    await transaction();
    if (tokenexpire == 401) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TimeOutPage()),
          (Route<dynamic> route) => false);
    }
    isLoading = false;
    setState(() {});
    print("fetch 2 ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF6F2DA8),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        // backgroundColor: Colors.transparent,
        // backgroundColor: Color(0xFFEBEDF2),
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0.0,
        leading: BackButton(
          color: Color(0xFF6F2DA8),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 50,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height(context: context) / 9,
                ),
                isLoading != true
                    ? (transactionsData.transactions.isEmpty
                        ? initiateFirst()
                        : transactionList())
                    : Container(
                        height: 633,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoActivityIndicator(),
                            Text(
                              "LOADING",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
              ],
            )),
      ),
    );
  }

  Widget initiateFirst() {
    return Column(
      children: [
        Container(
          height: 200,
          width: 370,
          decoration: BoxDecoration(
            // color: Color(0xFFEBEDF2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "No transactions in history.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget transactionList() {
    return Column(
        children: List.generate(
      transactionsData.transactions.length,
      (index) => Container(
        margin: const EdgeInsets.only(top: 16),
        height: 73,
        decoration: BoxDecoration(
          color: Color(0xFFEBEDF2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        transactionsData.transactions[index].name,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${transactionsData.transactions[index].points.toString()} Point(s)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color(0xFF6F2DA8),
                    thickness: 1,
                    endIndent: 5,
                  ),
                  Text(
                    transactionsData.transactions[index].createdAt
                        .add(new Duration(hours: 7))
                        .toIso8601String()
                        .replaceAll("T", " ")
                        .substring(0, 19),
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
