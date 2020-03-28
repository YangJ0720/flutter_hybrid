import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:module/route_channel.dart';
import 'package:module/route_fragment.dart';
import 'package:module/route_view.dart';

void main() => runApp(MyApp(
      initParams: window.defaultRouteName,
    ));

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        var result;
        switch (settings.name) {
          case 'view_route':
            result = RouteView(text: settings.name);
            break;
          case 'view_fragment':
            result = RouteFragment(text: settings.name);
            break;
          default:
            result = RouteChannel(text: settings.name);
            break;
        }
        return MaterialPageRoute(builder: (context) => result);
      },
    );
  }
}