// ignore_for_file: unused_local_variable, duplicate_ignore, non_constant_identifier_names
import 'dart:io';
import 'package:general_lib_flutter/general_lib_flutter.dart';
import "package:terminal_flutter/terminal_flutter.dart";
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory app_dir = await getApplicationSupportDirectory();
  runApp(TerminalFlutterApp());
}

class TerminalFlutterApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> theme_notifier = ValueNotifier<ThemeMode>(ThemeMode.system);
  TerminalFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralLibFlutterAppMain(
      theme_notifier: theme_notifier,
      builder: (themeMode, lightTheme, darkTheme, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const App(),
        );
      },
    );
  }
}

class App extends StatefulWidget {
  const App({
    super.key,
  });
  @override
  MyApp createState() => MyApp();
}

class MyApp extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const TerminalPage();
  }
}
