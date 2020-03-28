import 'package:flutter/material.dart';

class RouteFragment extends StatelessWidget {
  final String text;

  const RouteFragment({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fragment'),
      ),
      body: Container(
        child: Center(child: Text(text)),
      ),
      backgroundColor: Colors.orange,
    );
  }
}
