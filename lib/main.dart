import 'package:flutter/material.dart';
import 'package:p5_webviewx/p5_webviewx.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'P5 in Webviewx',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('P5 in Webviewx'),
            ),
            body: const P5Webviewx()));
  }
}
