import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAppOne extends StatelessWidget {
  const MyAppOne({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatelessWidget(),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text("Delete File"),
          content: Text("Are you sure you want to delete the file?"),
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
