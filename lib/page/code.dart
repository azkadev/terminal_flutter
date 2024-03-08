
import 'package:flutter/material.dart';
import 'package:xterm/core.dart';
 

enum VirtKey {
 
  esc,
  
  alt,
  
  home,
  
  up,
  
  end,
  
  sftp,
  
  snippet,
  
  tab,
  
  ctrl,
  
  left,
  
  down,
  
  right,
  
  clipboard,
  
  ime,
  
  pgup,
  
  pgdn;

  String get text {
    switch (this) {
      case VirtKey.pgdn:
        return 'PgDn';
      case VirtKey.pgup:
        return 'PgUp';
      default:
        if (name.length > 1) {
          return name.substring(0, 1).toUpperCase() + name.substring(1);
        }
        return name;
    }
  }

  TerminalKey? get key {
    switch (this) {
      case VirtKey.esc:
        return TerminalKey.escape;
      case VirtKey.alt:
        return TerminalKey.alt;
      case VirtKey.home:
        return TerminalKey.home;
      case VirtKey.up:
        return TerminalKey.arrowUp;
      case VirtKey.end:
        return TerminalKey.end;
      case VirtKey.tab:
        return TerminalKey.tab;
      case VirtKey.ctrl:
        return TerminalKey.control;
      case VirtKey.left:
        return TerminalKey.arrowLeft;
      case VirtKey.down:
        return TerminalKey.arrowDown;
      case VirtKey.right:
        return TerminalKey.arrowRight;
      case VirtKey.pgup:
        return TerminalKey.pageUp;
      case VirtKey.pgdn:
        return TerminalKey.pageDown;
      default:
        return null;
    }
  }

  IconData? get icon {
    switch (this) {
      case VirtKey.up:
        return Icons.arrow_upward;
      case VirtKey.left:
        return Icons.arrow_back;
      case VirtKey.down:
        return Icons.arrow_downward;
      case VirtKey.right:
        return Icons.arrow_forward;
      case VirtKey.sftp:
        return Icons.file_open;
      case VirtKey.snippet:
        return Icons.code;
      case VirtKey.clipboard:
        return Icons.paste;
      case VirtKey.ime:
        return Icons.keyboard_hide;
      default:
        return null;
    }
  }

  // Use [VirtualKeyFunc] instead of [VirtKey]
  // This can help linter to enum all [VirtualKeyFunc]
  // and make sure all [VirtualKeyFunc] are handled
  VirtualKeyFunc? get func {
    switch (this) {
      case VirtKey.sftp:
        return VirtualKeyFunc.file;
      case VirtKey.snippet:
        return VirtualKeyFunc.snippet;
      case VirtKey.clipboard:
        return VirtualKeyFunc.clipboard;
      case VirtKey.ime:
        return VirtualKeyFunc.toggleIME;
      default:
        return null;
    }
  }

  bool get toggleable {
    switch (this) {
      case VirtKey.alt:
      case VirtKey.ctrl:
        return true;
      default:
        return false;
    }
  }

  bool get canLongPress {
    switch (this) {
      case VirtKey.up:
      case VirtKey.left:
      case VirtKey.down:
      case VirtKey.right:
        return true;
      default:
        return false;
    }
  }

  String? get help {
    switch (this) {
      case VirtKey.sftp:
        return "sftp";
      case VirtKey.clipboard:
        return "clipboard";
      default:
        return null;
    }
  }
}

enum VirtualKeyFunc { toggleIME, backspace, clipboard, snippet, file }
