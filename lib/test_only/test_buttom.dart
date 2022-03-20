import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late bool _isButtonDisabled;

  // @override
  // void initState() {
  //   _isButtonDisabled = false;
  // }

  void _incrementCounter() {
    setState(() {
      _isButtonDisabled = true;
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("The App"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: TextStyle(fontSize: 25),
            ),
            _buildCounterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterButton() {
    return new MaterialButton(
      child: new Text(_isButtonDisabled ? "Hold on..." : "Increment"),
      onPressed: _isButtonDisabled ? null : _incrementCounter,
    );
  }
}
