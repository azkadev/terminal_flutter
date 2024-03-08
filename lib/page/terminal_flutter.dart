// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

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

    pty.output
        .cast<List<int>>()
        .transform(
          const Utf8Decoder(),
        )
        .listen(
          terminal.write,
        );

    pty.exitCode.then((code) {
      isterminal_active = false;
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (String data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onTitleChange = (String data) {
      title = data;
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  void addCommand({
    required String executable,
    required List<String> args,
  }) {
    pty.write(utf8.encode(
      [executable, ...args, "\n"].join(" "),
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
