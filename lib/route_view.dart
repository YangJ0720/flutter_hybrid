import 'package:flutter/material.dart';

class RouteView extends StatelessWidget {
  final String text;

  const RouteView({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View'),
      ),
      body: Container(
        child: Center(child: Text(text)),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
