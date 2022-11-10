// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:path_provider/path_provider.dart';
import 'core/core.dart';
import 'page/page.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory app_dir = await getApplicationSupportDirectory();
  debugRepaintRainbowEnabled = kDebugMode;
  runApp(MyApp(
    app_dir: app_dir,
  ));
  if (isDesktop) {
    doWhenWindowReady(() {
      const initialSize = Size(600, 450);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  final Directory app_dir;
  const MyApp({
    super.key,
    required this.app_dir,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        TerminalPage(
          app_dir: app_dir,
        ),
        //  App(
        //   app_dir: app_dir,
        // )
        // TerminalPage(
        //   app_dir: app_dir,
        // ),
        // shortcuts: ,
        );
  }
}

class App extends StatefulWidget {
  final Directory app_dir;
  const App({
    super.key,
    required this.app_dir,
  });

  @override
  MyApps createState() => MyApps();
}

class MyApps extends State<App> {
  final GlobalKey key = GlobalKey();
  @override
  // ignore: duplicate_ignore, duplicate_ignore
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: RepaintBoundary(
              key: key,
              child: Container(
                width: MediaQuery.of(context).size.width - 410,
                height: MediaQuery.of(context).size.height - 550,
                decoration: BoxDecoration(color: Color.fromARGB(255, 41, 55, 69), borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                padding: EdgeInsets.all(10),
                child: TerminalPage(
                  app_dir: widget.app_dir,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
          ui.Image image = await boundary.toImage(pixelRatio: 3);
          ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
          Uint8List pngBytes = byteData!.buffer.asUint8List();
          print(pngBytes);
          File("./data.png").writeAsBytes(pngBytes);
        },
        child: Icon(
          Icons.screen_lock_landscape,
        ),
      ),
    );
  }
}
