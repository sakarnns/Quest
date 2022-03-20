import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestBotoomUpPage extends StatefulWidget {
  TestBotoomUpPage({Key? key}) : super(key: key);

  @override
  _TestBotoomUpPageState createState() => _TestBotoomUpPageState();
}

class _TestBotoomUpPageState extends State<TestBotoomUpPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
