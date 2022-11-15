// ignore_for_file: unused_local_variable, duplicate_ignore, non_constant_identifier_names
import 'dart:io';
import "package:terminal_flutter/terminal_flutter.dart";
import 'package:flutter/material.dart'; 
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory app_dir = await getApplicationSupportDirectory();
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: true,
      title: "Azka Dev",
      home: App(app_dir: app_dir,),
    ),
  );
}

class App extends StatefulWidget {
  final Directory app_dir;
  const App({
    super.key,
    required this.app_dir,
  });
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<App> {
  @override
  Widget build(BuildContext context) {
    return TerminalPage(
      app_dir: widget.app_dir,
    );
  }
}
