part of terminal_core;

class TerminalClient {
  late String title;
  late Terminal terminal;
  late TerminalController terminalController;
  late bool isActive;
  late Pty pty;
  TerminalClient({
    required this.title,
    required this.terminal,
    required this.terminalController,
    this.isActive = false,
  }) {
    startPty();
  }

  String get shell {
    if (Platform.isMacOS || Platform.isLinux) {
      return Platform.environment['SHELL'] ?? 'bash';
    }

    if (Platform.isWindows) {
      return 'cmd.exe';
    }
    // String? get_app_path = getAppDir();
    // if (get_app_path != null) {
    //   return "${get_app_path}/files/usr/bin/sh";
    // }

    return 'sh';
  }

  void startPty() {
    pty = Pty.start(
      shell,
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    // pty.output.cast<List<int>>().transform(const Utf8Decoder()).listen(terminal.write);
    pty.output.cast<List<int>>().transform(const Utf8Decoder()).listen(terminal.write);
     
    pty.exitCode.then((code) {
      isActive = false;
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
}

extension TerminalClientExtensions on List<TerminalClient> {
  TerminalClient getTerminalActiveForce() {
    while (true) {
      TerminalClient? terminalClient = getTerminalActive();
      if (terminalClient != null) {
        return terminalClient;
      } else {
        add(
          TerminalClient(
            title: "Helo",
            terminal: Terminal(
              maxLines: 10000,
            ),
            terminalController: TerminalController(),
            isActive: true,
          ),
        );
      }
    }
  }

  TerminalClient? getTerminalActive() {
    for (var i = 0; i < length; i++) {
      if (this[i].isActive) {
        return this[i];
      }
    }
    return null;
  }

  void setInactiveAll() {
    for (var i = 0; i < length; i++) {
      if (this[i].isActive) {
        this[i].isActive = false;
      }
    }
    return;
  }

  void setActiveIndex({required int index}) {
    for (var i = 0; i < length; i++) {
      if (i == index) {
        setInactiveAll();
        this[i].isActive = true;
      }
    }
    return;
  }

  void close({required int index}) {
    for (var i = 0; i < length; i++) {
      if (i == index) {
        this[i].terminalController.removeListener(() {});
        this[i].terminal.removeListener(() {});
        removeAt(i);
        return;
      }
    }
    return;
  }

  TerminalClient initNew() {
    setInactiveAll();
    TerminalClient terminalClient = TerminalClient(
      title: "Helo",
      terminal: Terminal(
        maxLines: 10000,
      ),
      terminalController: TerminalController(),
      isActive: true,
    );
    add(terminalClient);
    return terminalClient;
  }
}
