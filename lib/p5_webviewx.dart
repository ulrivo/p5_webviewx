import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class P5Webviewx extends StatefulWidget {
  const P5Webviewx({Key? key}) : super(key: key);

  @override
  State<P5Webviewx> createState() => _P5WebviewxState();
}

class _P5WebviewxState extends State<P5Webviewx> {
  WebViewXController? webviewController;
  static const String indexHtml1 = '''
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      html,
      body {
        margin: 0;
        padding: 0;
      }
      canvas {
        display: block;
      }
    </style>
    <title>Sketch</title>
    <script src="https://cdn.jsdelivr.net/npm/p5@1.4.2/lib/p5.js"></script>
  </head>
  <body>
    <script type="text/javascript">
  ''';
  static const String indexHtml2 = '''
      </script>
    </body>
  </html>
  ''';

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String initialSource = '''
        function setup() {
          createCanvas(800, 400);
          console.log('in setup');
        }
        function draw() {
          if (mouseIsPressed) {
            fill(255, 0, 255);
          } else {
            fill(255);
          }
          ellipse(mouseX, mouseY, 80, 80);
        }
        ''';
    const String wrongSource = '''
        function setup() {
          createCanvas(800, 400);
          console.log('in setup');
        }
        function draw() {
          if (mouseIsPressed) {
            fill(255, 0, 255);
          } els {
            fill(255);
          }
          ellipse(mouseX, mouseY, 80, 80);
        }
        ''';
    const String initialContent = '$indexHtml1 $initialSource $indexHtml2';
    const String wrongContent = '$indexHtml1 $wrongSource $indexHtml2';
    // for the first time webviewController is null
    webviewController?.loadContent(
      wrongContent,
      SourceType.html,
      fromAssets: false,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text('Wrong Source')),
        ),
        WebViewX(
          key: const ValueKey('webviewx'),
          initialContent: initialContent,
          initialSourceType: SourceType.html,
          height: screenSize.height - 100,
          width: min(screenSize.width * 0.8, 1024),
          onWebViewCreated: (controller) {
            webviewController = controller;
          },
          webSpecificParams: const WebSpecificParams(
            printDebugInfo: true,
          ),
          onWebResourceError: (error) =>
              debugPrint('onWebResourceError ${error.toString()}'),
          navigationDelegate: (navigation) {
            debugPrint(navigation.content.sourceType.toString());
            return NavigationDecision.navigate;
          },
          dartCallBacks: {
            DartCallback(
                name: 'DartLog',
                callBack: (message) {
                  debugPrint('>>>  $message <<<');
                }),
          },
          jsContent: const {
            EmbeddedJsContent(
                mobileJs: '',
                webJs: 'console.log = (message) => DartLog(message);;')
          },
        ),
      ],
    );
  }
}
