import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RouteChannel extends StatefulWidget {
  final String text;

  const RouteChannel({Key key, this.text}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return RouteChannelState();
  }
}

class RouteChannelState extends State<RouteChannel> {
  String msg;
  String msgMethod;
  String msgEvent;

  /// BasicMessageChannel
  static const BasicMessageChannel<String> _basicMessageChannel =
      BasicMessageChannel("basic_message_channel", StringCodec());

  /// MethodChannel
  static const MethodChannel _methodChannel = MethodChannel("method_channel");

  /// EventChannel
  static const EventChannel _eventChannel = EventChannel("event_channel");
  StreamSubscription _streamSubscription;

  void _onEvent(Object event) {
    setState(() {
      msgEvent = event.toString();
    });
  }

  void _onError(Object error) {
    setState(() {
      msgEvent = error.toString();
    });
  }

  @override
  void initState() {
    /// BasicMessageChannel
    _basicMessageChannel
        .setMessageHandler((String message) => Future<String>(() {
              String msg = "$message";
              setState(() {
                this.msg = msg;
              });
              return msg;
            }));

    /// MethodChannel
    _methodChannel
        .setMethodCallHandler((dynamic message) => Future<dynamic>(() {
              setState(() {
                msgMethod = message.toString();
              });
              return "message = $message";
            }));

    /// EventChannel
    print('_eventChannel = $_eventChannel');
    print('_streamSubscription = $_streamSubscription');
    _streamSubscription = _eventChannel
        .receiveBroadcastStream('Flutter Event Channel')
        .listen(_onEvent, onError: _onError, cancelOnError: true);
    super.initState();
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:${widget.text}',
            ),
            Text(
              'BasicMessageChannel',
              style: TextStyle(color: Colors.blue),
            ),
            Text('$msg'),
            MaterialButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('BasicMessageChannel发送消息给Native'),
              onPressed: () {
                String text = "Flutter Message: ${DateTime.now()}";
                _basicMessageChannel.send(text);
              },
            ),
            Text(
              'MethodChannel',
              style: TextStyle(color: Colors.blue),
            ),
            Text('$msgMethod'),
            MaterialButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                /// 调用Native的login方法，传递一个int类型的随机数
                int number = Random().nextInt(10);

                /// 传递一个string类型的时间
                String time = DateTime.now().toString();

                /// 调用native的login方法
                _methodChannel.invokeMethod('login', [number, time]);
              },
              child: Text('MethodChannel发送消息给Native'),
            ),
            Text(
              'EventChannel',
              style: TextStyle(color: Colors.blue),
            ),
            Text('$msgEvent')
          ],
        ),
      ),
    );
  }
}
