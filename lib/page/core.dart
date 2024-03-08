// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:terminal_flutter/package/package.dart';
 

class VirtKeyProvider extends TerminalInputHandler with ChangeNotifier {
  bool is_ssh;
  VirtKeyProvider({
    this.is_ssh = false,
  });

  bool _ctrl = false;
  bool get ctrl => _ctrl;
  set ctrl(bool value) {
    if (value != _ctrl) {
      _ctrl = value;
      notifyListeners();
    }
  }

  bool _alt = false;
  bool get alt => _alt;
  set alt(bool value) {
    if (value != _alt) {
      _alt = value;
      notifyListeners();
    }
  }

  void reset(TerminalKeyboardEvent e) {
    if (e.ctrl) {
      ctrl = false;
    }
    if (e.alt) {
      alt = false;
    }
    notifyListeners();
  }

  @override
  String? call(TerminalKeyboardEvent event) {
    final e = event.copyWith(
      ctrl: event.ctrl || ctrl,
      alt: event.alt || alt,
    );
    if (is_ssh) {
      // if (Stores.setting.sshVirtualKeyAutoOff.fetch()) {
      // reset(e);
      // }
    }
    return defaultInputHandler.call(e);
  }
}



