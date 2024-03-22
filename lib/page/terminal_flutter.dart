// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:general_lib/general_lib.dart';
import 'package:terminal_flutter/package/package.dart';

class TerminalFlutter {
  late Pty pty;
  late TerminalController terminalController;
  late Terminal terminal;
  bool isterminal_active = false;
  String title = "";

  double textScaleFactor = 1;
  TerminalFlutter();

  Future<void> init({
    required Terminal terminalLib,
    required TerminalController terminalControllerLib,
    required Pty ptyLib,
  }) async {
    terminal = terminalLib;
    terminalController = terminalControllerLib;
    pty = ptyLib;
    pty.output.listen((event) {
      updateData(event);
    });

    pty.exitCode.then((code) {
      isterminal_active = false;
      terminal.write('the process exited with exit code ${code}');
    });

    terminal.onOutput = onOutput;

    terminal.onTitleChange = (String data) {
      title = data;
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  void updateData(Uint8List event) {
    if (event.isNotEmpty) {
      try {
        terminal.write(utf8.decode(event, allowMalformed: true));
      } catch (e) {}
    }
  }

  void onOutput(String data) {
    if (data.isNotEmpty) {
      try {
        pty.write(utf8.encode(data));
      } catch (e) {}
    }
  }

  void addCommand({
    required String executable,
    required List<String> args,
    required bool isAddSh,
  }) {
    List<String> exes = [
      executable,
      ...args,
      "\n",
    ];

    if (isAddSh ) {
      if (dart.isAndroid) {
        exes.add("sh");
      }
    }

    pty.write(utf8.encode(
      exes.join(" "),
    ));
  }

  void scaleDown() {
    double res = textScaleFactor - 0.2;
    if (res < 0.1) {
      return;
    }

    textScaleFactor = res;
  }

  void scaleUp() {
    // setState(() {
    textScaleFactor = (textScaleFactor + 0.2);
    // });
  }
}
