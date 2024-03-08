 

import 'package:universal_io/io.dart';

class TerminalNativeShell {
  static String get shell {
    if (Platform.isMacOS || Platform.isLinux) {
      return Platform.environment['SHELL'] ?? 'bash';
    }

    if (Platform.isWindows) {
      return 'cmd.exe';
    }
    return 'sh';
  }
}
