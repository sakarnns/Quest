import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quest_2/styles/size.dart';

class TestPageSelect extends StatefulWidget {
  TestPageSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<TestPageSelect> createState() => _TestPageSelectState();
}

class _TestPageSelectState extends State<TestPageSelect> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Transaction',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            backgroundColor: Colors.transparent,
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
                  Image.network(
                      'http://ec2-13-229-230-197.ap-southeast-1.compute.amazonaws.com/api/Quest/image_display/55347d5578570bca3a0e26f4d43f9d17')
                ],
              ),
            ),
          )),
    );
  }
}
