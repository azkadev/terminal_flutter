// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terminal_flutter/terminal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory app_dir = await getApplicationSupportDirectory();
  // debugRepaintRainbowEnabled = kDebugMode;
  runApp(MyApp(
    app_dir: app_dir,
  ));
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
      home: TerminalPage(
        app_dir: app_dir,
      ),
    );
  }
}
