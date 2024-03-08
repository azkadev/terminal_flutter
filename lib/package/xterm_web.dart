import 'package:flutter/material.dart';

class TerminalController {
  TerminalController();
  BufferRange? get selection {
    return null;
  }

  /// Clears the current selection.
  void clearSelection() { 
  }
}

abstract class BufferRange {
  final dynamic begin;

  final dynamic end;

  const BufferRange(this.begin, this.end);

  BufferRange.collapsed(this.begin) : end = begin;

  bool get isNormalized {
    return begin.isBefore(end) || begin.isEqual(end);
  }

  bool get isCollapsed {
    return begin.isEqual(end);
  }

  BufferRange get normalized;

  /// Convert this range to segments of single lines.
  Iterable<dynamic> toSegments();

  /// Returns true if the given[position] is within this range.
  bool contains(dynamic position);

  /// Returns the smallest range that contains both this range and the given
  /// [range].
  BufferRange merge(BufferRange range);

  /// Returns the smallest range that contains both this range and the given
  /// [position].
  BufferRange extend(dynamic position);

  @override
  operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! BufferRange) {
      return false;
    }

    return begin == other.begin && end == other.end;
  }

  @override
  int get hashCode => begin.hashCode ^ end.hashCode;

  @override
  String toString() => 'Range($begin, $end)';
}

class Terminal {
  void Function(String data)? onOutput;
  void Function(String title)? onTitleChange;

  Buffer get buffer => Buffer();

  void paste(String text) {
    
  }


  /// Function that is called when the dimensions of the terminal change.
  void Function(int width, int height, int pixelWidth, int pixelHeight)? onResize;
  Terminal({
    maxLines,
    inputHandler,
  });
  int get viewWidth {
    return 0;
  }

  void keyInput(dynamic data) {
    return;
  }

  int get viewHeight {
    return 0;
  }

  void write(String data) {}
}

class TerminalView extends StatefulWidget {
  const TerminalView(
    terminal, {
    super.key,
    controller,
    theme,
    textStyle,
    textScaler,
    padding,
    scrollController,
    autoResize = true,
    backgroundOpacity = 1,
    focusNode,
    autofocus = false,
    onTapUp,
    onSecondaryTapDown,
    onSecondaryTapUp,
    mouseCursor = SystemMouseCursors.text,
    keyboardType = TextInputType.emailAddress,
    keyboardAppearance = Brightness.dark,
    cursorType,
    alwaysShowCursor = false,
    deleteDetection = false,
    shortcuts,
    onKeyEvent,
    readOnly = false,
    hardwareKeyboardOnly = false,
    simulateScroll = true,
  });

  @override
  State<TerminalView> createState() => _TerminalViewState();
}

class _TerminalViewState extends State<TerminalView> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class TerminalThemes {
  static const defaultTheme = TerminalTheme(
    cursor: Color(0XAAAEAFAD),
    selection: Color(0XAAAEAFAD),
    foreground: Color(0XFFCCCCCC),
    background: Color(0XFF1E1E1E),
    black: Color(0XFF000000),
    red: Color(0XFFCD3131),
    green: Color(0XFF0DBC79),
    yellow: Color(0XFFE5E510),
    blue: Color(0XFF2472C8),
    magenta: Color(0XFFBC3FBC),
    cyan: Color(0XFF11A8CD),
    white: Color(0XFFE5E5E5),
    brightBlack: Color(0XFF666666),
    brightRed: Color(0XFFF14C4C),
    brightGreen: Color(0XFF23D18B),
    brightYellow: Color(0XFFF5F543),
    brightBlue: Color(0XFF3B8EEA),
    brightMagenta: Color(0XFFD670D6),
    brightCyan: Color(0XFF29B8DB),
    brightWhite: Color(0XFFFFFFFF),
    searchHitBackground: Color(0XFFFFFF2B),
    searchHitBackgroundCurrent: Color(0XFF31FF26),
    searchHitForeground: Color(0XFF000000),
  );

  static const whiteOnBlack = TerminalTheme(
    cursor: Color(0XFFAEAFAD),
    selection: Color(0XFFAEAFAD),
    foreground: Color(0XFFFFFFFF),
    background: Color(0XFF000000),
    black: Color(0XFF000000),
    red: Color(0XFFCD3131),
    green: Color(0XFF0DBC79),
    yellow: Color(0XFFE5E510),
    blue: Color(0XFF2472C8),
    magenta: Color(0XFFBC3FBC),
    cyan: Color(0XFF11A8CD),
    white: Color(0XFFE5E5E5),
    brightBlack: Color(0XFF666666),
    brightRed: Color(0XFFF14C4C),
    brightGreen: Color(0XFF23D18B),
    brightYellow: Color(0XFFF5F543),
    brightBlue: Color(0XFF3B8EEA),
    brightMagenta: Color(0XFFD670D6),
    brightCyan: Color(0XFF29B8DB),
    brightWhite: Color(0XFFFFFFFF),
    searchHitBackground: Color(0XFFFFFF2B),
    searchHitBackgroundCurrent: Color(0XFF31FF26),
    searchHitForeground: Color(0XFF000000),
  );
}

class TerminalTheme {
  const TerminalTheme({
    required this.cursor,
    required this.selection,
    required this.foreground,
    required this.background,
    required this.black,
    required this.white,
    required this.red,
    required this.green,
    required this.yellow,
    required this.blue,
    required this.magenta,
    required this.cyan,
    required this.brightBlack,
    required this.brightRed,
    required this.brightGreen,
    required this.brightYellow,
    required this.brightBlue,
    required this.brightMagenta,
    required this.brightCyan,
    required this.brightWhite,
    required this.searchHitBackground,
    required this.searchHitBackgroundCurrent,
    required this.searchHitForeground,
  });

  final Color cursor;
  final Color selection;

  final Color foreground;
  final Color background;

  final Color black;
  final Color red;
  final Color green;
  final Color yellow;
  final Color blue;
  final Color magenta;
  final Color cyan;
  final Color white;

  final Color brightBlack;
  final Color brightRed;
  final Color brightGreen;
  final Color brightYellow;
  final Color brightBlue;
  final Color brightMagenta;
  final Color brightCyan;
  final Color brightWhite;

  final Color searchHitBackground;
  final Color searchHitBackgroundCurrent;
  final Color searchHitForeground;
}

class Buffer {
  
  /// Get the plain text content of the buffer including the scrollback.
  /// Accepts an optional [range] to get a specific part of the buffer.
  String getText([BufferRange? range]) {
    return "";
  }

}

enum TerminalKey {
  /// Represents the logical "None" key on the keyboard.
  none,

  /// Represents the logical "Hyper" key on the keyboard.
  hyper,

  /// Represents the logical "Super Key" key on the keyboard.
  superKey,

  /// Represents the logical "Fn Lock" key on the keyboard.
  fnLock,

  /// Represents the logical "Suspend" key on the keyboard.
  suspend,

  /// Represents the logical "Resume" key on the keyboard.
  resume,

  /// Represents the logical "Turbo" key on the keyboard.
  turbo,

  /// Represents the logical "Privacy Screen Toggle" key on the keyboard.
  privacyScreenToggle,

  /// Represents the logical "Sleep" key on the keyboard.
  sleep,

  /// Represents the logical "Wake Up" key on the keyboard.
  wakeUp,

  /// Represents the logical "Display Toggle Int Ext" key on the keyboard.
  displayToggleIntExt,

  /// Represents the logical "Usb Reserved" key on the keyboard.
  usbReserved,

  /// Represents the logical "Usb Error Roll Over" key on the keyboard.
  usbErrorRollOver,

  /// Represents the logical "Usb Post Fail" key on the keyboard.
  usbPostFail,

  /// Represents the logical "Usb Error Undefined" key on the keyboard.
  usbErrorUndefined,

  /// Represents the logical "Key A" key on the keyboard.
  keyA,

  /// Represents the logical "Key B" key on the keyboard.
  keyB,

  /// Represents the logical "Key C" key on the keyboard.
  keyC,

  /// Represents the logical "Key D" key on the keyboard.
  keyD,

  /// Represents the logical "Key E" key on the keyboard.
  keyE,

  /// Represents the logical "Key F" key on the keyboard.
  keyF,

  /// Represents the logical "Key G" key on the keyboard.
  keyG,

  /// Represents the logical "Key H" key on the keyboard.
  keyH,

  /// Represents the logical "Key I" key on the keyboard.
  keyI,

  /// Represents the logical "Key J" key on the keyboard.
  keyJ,

  /// Represents the logical "Key K" key on the keyboard.
  keyK,

  /// Represents the logical "Key L" key on the keyboard.
  keyL,

  /// Represents the logical "Key M" key on the keyboard.
  keyM,

  /// Represents the logical "Key N" key on the keyboard.
  keyN,

  /// Represents the logical "Key O" key on the keyboard.
  keyO,

  /// Represents the logical "Key P" key on the keyboard.
  keyP,

  /// Represents the logical "Key Q" key on the keyboard.
  keyQ,

  /// Represents the logical "Key R" key on the keyboard.
  keyR,

  /// Represents the logical "Key S" key on the keyboard.
  keyS,

  /// Represents the logical "Key T" key on the keyboard.
  keyT,

  /// Represents the logical "Key U" key on the keyboard.
  keyU,

  /// Represents the logical "Key V" key on the keyboard.
  keyV,

  /// Represents the logical "Key W" key on the keyboard.
  keyW,

  /// Represents the logical "Key X" key on the keyboard.
  keyX,

  /// Represents the logical "Key Y" key on the keyboard.
  keyY,

  /// Represents the logical "Key Z" key on the keyboard.
  keyZ,

  /// Represents the logical "Digit 1" key on the keyboard.
  digit1,

  /// Represents the logical "Digit 2" key on the keyboard.
  digit2,

  /// Represents the logical "Digit 3" key on the keyboard.
  digit3,

  /// Represents the logical "Digit 4" key on the keyboard.
  digit4,

  /// Represents the logical "Digit 5" key on the keyboard.
  digit5,

  /// Represents the logical "Digit 6" key on the keyboard.
  digit6,

  /// Represents the logical "Digit 7" key on the keyboard.
  digit7,

  /// Represents the logical "Digit 8" key on the keyboard.
  digit8,

  /// Represents the logical "Digit 9" key on the keyboard.
  digit9,

  /// Represents the logical "Digit 0" key on the keyboard.
  digit0,

  /// Represents the logical "Enter" key on the keyboard.
  enter,

  /// Represents the logical "Escape" key on the keyboard.
  escape,

  /// Represents the logical "Backspace" key on the keyboard.
  backspace,

  /// Represents the logical "Tab" key on the keyboard.
  tab,

  /// Represents the logical "Space" key on the keyboard.
  space,

  /// Represents the logical "Minus" key on the keyboard.
  minus,

  /// Represents the logical "Equal" key on the keyboard.
  equal,

  /// Represents the logical "Bracket Left" key on the keyboard.
  bracketLeft,

  /// Represents the logical "Bracket Right" key on the keyboard.
  bracketRight,

  /// Represents the logical "Backslash" key on the keyboard.
  backslash,

  /// Represents the logical "Semicolon" key on the keyboard.
  semicolon,

  /// Represents the logical "Quote" key on the keyboard.
  quote,

  /// Represents the logical "Backquote" key on the keyboard.
  backquote,

  /// Represents the logical "Comma" key on the keyboard.
  comma,

  /// Represents the logical "Period" key on the keyboard.
  period,

  /// Represents the logical "Slash" key on the keyboard.
  slash,

  /// Represents the logical "Caps Lock" key on the keyboard.
  capsLock,

  /// Represents the logical "F1" key on the keyboard.
  f1,

  /// Represents the logical "F2" key on the keyboard.
  f2,

  /// Represents the logical "F3" key on the keyboard.
  f3,

  /// Represents the logical "F4" key on the keyboard.
  f4,

  /// Represents the logical "F5" key on the keyboard.
  f5,

  /// Represents the logical "F6" key on the keyboard.
  f6,

  /// Represents the logical "F7" key on the keyboard.
  f7,

  /// Represents the logical "F8" key on the keyboard.
  f8,

  /// Represents the logical "F9" key on the keyboard.
  f9,

  /// Represents the logical "F10" key on the keyboard.
  f10,

  /// Represents the logical "F11" key on the keyboard.
  f11,

  /// Represents the logical "F12" key on the keyboard.
  f12,

  /// Represents the logical "Print Screen" key on the keyboard.
  printScreen,

  /// Represents the logical "Scroll Lock" key on the keyboard.
  scrollLock,

  /// Represents the logical "Pause" key on the keyboard.
  pause,

  /// Represents the logical "Insert" key on the keyboard.
  insert,

  /// Represents the logical "Home" key on the keyboard.
  home,

  /// Represents the logical "Page Up" key on the keyboard.
  pageUp,

  /// Represents the logical "Delete" key on the keyboard.
  delete,

  /// Represents the logical "End" key on the keyboard.
  end,

  /// Represents the logical "Page Down" key on the keyboard.
  pageDown,

  /// Represents the logical "Arrow Right" key on the keyboard.
  arrowRight,

  /// Represents the logical "Arrow Left" key on the keyboard.
  arrowLeft,

  /// Represents the logical "Arrow Down" key on the keyboard.
  arrowDown,

  /// Represents the logical "Arrow Up" key on the keyboard.
  arrowUp,

  /// Represents the logical "Num Lock" key on the keyboard.
  numLock,

  /// Represents the logical "Numpad Divide" key on the keyboard.
  numpadDivide,

  /// Represents the logical "Numpad Multiply" key on the keyboard.
  numpadMultiply,

  /// Represents the logical "Numpad Subtract" key on the keyboard.
  numpadSubtract,

  /// Represents the logical "Numpad Add" key on the keyboard.
  numpadAdd,

  /// Represents the logical "Numpad Enter" key on the keyboard.
  numpadEnter,

  /// Represents the logical "Numpad 1" key on the keyboard.
  numpad1,

  /// Represents the logical "Numpad 2" key on the keyboard.
  numpad2,

  /// Represents the logical "Numpad 3" key on the keyboard.
  numpad3,

  /// Represents the logical "Numpad 4" key on the keyboard.
  numpad4,

  /// Represents the logical "Numpad 5" key on the keyboard.
  numpad5,

  /// Represents the logical "Numpad 6" key on the keyboard.
  numpad6,

  /// Represents the logical "Numpad 7" key on the keyboard.
  numpad7,

  /// Represents the logical "Numpad 8" key on the keyboard.
  numpad8,

  /// Represents the logical "Numpad 9" key on the keyboard.
  numpad9,

  /// Represents the logical "Numpad 0" key on the keyboard.
  numpad0,

  /// Represents the logical "Numpad Decimal" key on the keyboard.
  numpadDecimal,

  /// Represents the logical "Intl Backslash" key on the keyboard.
  intlBackslash,

  /// Represents the logical "Context Menu" key on the keyboard.
  contextMenu,

  /// Represents the logical "Power" key on the keyboard.
  power,

  /// Represents the logical "Numpad Equal" key on the keyboard.
  numpadEqual,

  /// Represents the logical "F13" key on the keyboard.
  f13,

  /// Represents the logical "F14" key on the keyboard.
  f14,

  /// Represents the logical "F15" key on the keyboard.
  f15,

  /// Represents the logical "F16" key on the keyboard.
  f16,

  /// Represents the logical "F17" key on the keyboard.
  f17,

  /// Represents the logical "F18" key on the keyboard.
  f18,

  /// Represents the logical "F19" key on the keyboard.
  f19,

  /// Represents the logical "F20" key on the keyboard.
  f20,

  /// Represents the logical "F21" key on the keyboard.
  f21,

  /// Represents the logical "F22" key on the keyboard.
  f22,

  /// Represents the logical "F23" key on the keyboard.
  f23,

  /// Represents the logical "F24" key on the keyboard.
  f24,

  /// Represents the logical "Open" key on the keyboard.
  open,

  /// Represents the logical "Help" key on the keyboard.
  help,

  /// Represents the logical "Select" key on the keyboard.
  select,

  /// Represents the logical "Again" key on the keyboard.
  again,

  /// Represents the logical "Undo" key on the keyboard.
  undo,

  /// Represents the logical "Cut" key on the keyboard.
  cut,

  /// Represents the logical "Copy" key on the keyboard.
  copy,

  /// Represents the logical "Paste" key on the keyboard.
  paste,

  /// Represents the logical "Find" key on the keyboard.
  find,

  /// Represents the logical "Audio Volume Mute" key on the keyboard.
  audioVolumeMute,

  /// Represents the logical "Audio Volume Up" key on the keyboard.
  audioVolumeUp,

  /// Represents the logical "Audio Volume Down" key on the keyboard.
  audioVolumeDown,

  /// Represents the logical "Numpad Comma" key on the keyboard.
  numpadComma,

  /// Represents the logical "Intl Ro" key on the keyboard.
  intlRo,

  /// Represents the logical "Kana Mode" key on the keyboard.
  kanaMode,

  /// Represents the logical "Intl Yen" key on the keyboard.
  intlYen,

  /// Represents the logical "Convert" key on the keyboard.
  convert,

  /// Represents the logical "Non Convert" key on the keyboard.
  nonConvert,

  /// Represents the logical "Lang 1" key on the keyboard.
  lang1,

  /// Represents the logical "Lang 2" key on the keyboard.
  lang2,

  /// Represents the logical "Lang 3" key on the keyboard.
  lang3,

  /// Represents the logical "Lang 4" key on the keyboard.
  lang4,

  /// Represents the logical "Lang 5" key on the keyboard.
  lang5,

  /// Represents the logical "Abort" key on the keyboard.
  abort,

  /// Represents the logical "Props" key on the keyboard.
  props,

  /// Represents the logical "Numpad Paren Left" key on the keyboard.
  numpadParenLeft,

  /// Represents the logical "Numpad Paren Right" key on the keyboard.
  numpadParenRight,

  /// Represents the logical "Numpad Backspace" key on the keyboard.
  numpadBackspace,

  /// Represents the logical "Numpad Memory Store" key on the keyboard.
  numpadMemoryStore,

  /// Represents the logical "Numpad Memory Recall" key on the keyboard.
  numpadMemoryRecall,

  /// Represents the logical "Numpad Memory Clear" key on the keyboard.
  numpadMemoryClear,

  /// Represents the logical "Numpad Memory Add" key on the keyboard.
  numpadMemoryAdd,

  /// Represents the logical "Numpad Memory Subtract" key on the keyboard.
  numpadMemorySubtract,

  /// Represents the logical "Numpad Sign Change" key on the keyboard.
  numpadSignChange,

  /// Represents the logical "Numpad Clear" key on the keyboard.
  numpadClear,

  /// Represents the logical "Numpad Clear Entry" key on the keyboard.
  numpadClearEntry,

  /// Represents the logical "Control Left" key on the keyboard.
  controlLeft,

  /// Represents the logical "Shift Left" key on the keyboard.
  shiftLeft,

  /// Represents the logical "Alt Left" key on the keyboard.
  altLeft,

  /// Represents the logical "Meta Left" key on the keyboard.
  metaLeft,

  /// Represents the logical "Control Right" key on the keyboard.
  controlRight,

  /// Represents the logical "Shift Right" key on the keyboard.
  shiftRight,

  /// Represents the logical "Alt Right" key on the keyboard.
  altRight,

  /// Represents the logical "Meta Right" key on the keyboard.
  metaRight,

  /// Represents the logical "Info" key on the keyboard.
  info,

  /// Represents the logical "Closed Caption Toggle" key on the keyboard.
  closedCaptionToggle,

  /// Represents the logical "Brightness Up" key on the keyboard.
  brightnessUp,

  /// Represents the logical "Brightness Down" key on the keyboard.
  brightnessDown,

  /// Represents the logical "Brightness Toggle" key on the keyboard.
  brightnessToggle,

  /// Represents the logical "Brightness Minimum" key on the keyboard.
  brightnessMinimum,

  /// Represents the logical "Brightness Maximum" key on the keyboard.
  brightnessMaximum,

  /// Represents the logical "Brightness Auto" key on the keyboard.
  brightnessAuto,

  /// Represents the logical "Media Last" key on the keyboard.
  mediaLast,

  /// Represents the logical "Launch Phone" key on the keyboard.
  launchPhone,

  /// Represents the logical "Program Guide" key on the keyboard.
  programGuide,

  /// Represents the logical "Exit" key on the keyboard.
  exit,

  /// Represents the logical "Channel Up" key on the keyboard.
  channelUp,

  /// Represents the logical "Channel Down" key on the keyboard.
  channelDown,

  /// Represents the logical "Media Play" key on the keyboard.
  mediaPlay,

  /// Represents the logical "Media Pause" key on the keyboard.
  mediaPause,

  /// Represents the logical "Media Record" key on the keyboard.
  mediaRecord,

  /// Represents the logical "Media Fast Forward" key on the keyboard.
  mediaFastForward,

  /// Represents the logical "Media Rewind" key on the keyboard.
  mediaRewind,

  /// Represents the logical "Media Track Next" key on the keyboard.
  mediaTrackNext,

  /// Represents the logical "Media Track Previous" key on the keyboard.
  mediaTrackPrevious,

  /// Represents the logical "Media Stop" key on the keyboard.
  mediaStop,

  /// Represents the logical "Eject" key on the keyboard.
  eject,

  /// Represents the logical "Media Play Pause" key on the keyboard.
  mediaPlayPause,

  /// Represents the logical "Speech Input Toggle" key on the keyboard.
  speechInputToggle,

  /// Represents the logical "Bass Boost" key on the keyboard.
  bassBoost,

  /// Represents the logical "Media Select" key on the keyboard.
  mediaSelect,

  /// Represents the logical "Launch Word Processor" key on the keyboard.
  launchWordProcessor,

  /// Represents the logical "Launch Spreadsheet" key on the keyboard.
  launchSpreadsheet,

  /// Represents the logical "Launch Mail" key on the keyboard.
  launchMail,

  /// Represents the logical "Launch Contacts" key on the keyboard.
  launchContacts,

  /// Represents the logical "Launch Calendar" key on the keyboard.
  launchCalendar,

  /// Represents the logical "Launch App2" key on the keyboard.
  launchApp2,

  /// Represents the logical "Launch App1" key on the keyboard.
  launchApp1,

  /// Represents the logical "Launch Internet Browser" key on the keyboard.
  launchInternetBrowser,

  /// Represents the logical "Log Off" key on the keyboard.
  logOff,

  /// Represents the logical "Lock Screen" key on the keyboard.
  lockScreen,

  /// Represents the logical "Launch Control Panel" key on the keyboard.
  launchControlPanel,

  /// Represents the logical "Select Task" key on the keyboard.
  selectTask,

  /// Represents the logical "Launch Documents" key on the keyboard.
  launchDocuments,

  /// Represents the logical "Spell Check" key on the keyboard.
  spellCheck,

  /// Represents the logical "Launch Keyboard Layout" key on the keyboard.
  launchKeyboardLayout,

  /// Represents the logical "Launch Screen Saver" key on the keyboard.
  launchScreenSaver,

  /// Represents the logical "Launch Assistant" key on the keyboard.
  launchAssistant,

  /// Represents the logical "Launch Audio Browser" key on the keyboard.
  launchAudioBrowser,

  /// Represents the logical "New Key" key on the keyboard.
  newKey,

  /// Represents the logical "Close" key on the keyboard.
  close,

  /// Represents the logical "Save" key on the keyboard.
  save,

  /// Represents the logical "Print" key on the keyboard.
  print,

  /// Represents the logical "Browser Search" key on the keyboard.
  browserSearch,

  /// Represents the logical "Browser Home" key on the keyboard.
  browserHome,

  /// Represents the logical "Browser Back" key on the keyboard.
  browserBack,

  /// Represents the logical "Browser Forward" key on the keyboard.
  browserForward,

  /// Represents the logical "Browser Stop" key on the keyboard.
  browserStop,

  /// Represents the logical "Browser Refresh" key on the keyboard.
  browserRefresh,

  /// Represents the logical "Browser Favorites" key on the keyboard.
  browserFavorites,

  /// Represents the logical "Zoom In" key on the keyboard.
  zoomIn,

  /// Represents the logical "Zoom Out" key on the keyboard.
  zoomOut,

  /// Represents the logical "Zoom Toggle" key on the keyboard.
  zoomToggle,

  /// Represents the logical "Redo" key on the keyboard.
  redo,

  /// Represents the logical "Mail Reply" key on the keyboard.
  mailReply,

  /// Represents the logical "Mail Forward" key on the keyboard.
  mailForward,

  /// Represents the logical "Mail Send" key on the keyboard.
  mailSend,

  /// Represents the logical "Keyboard Layout Select" key on the keyboard.
  keyboardLayoutSelect,

  /// Represents the logical "Show All Windows" key on the keyboard.
  showAllWindows,

  /// Represents the logical "Game Button 1" key on the keyboard.
  gameButton1,

  /// Represents the logical "Game Button 2" key on the keyboard.
  gameButton2,

  /// Represents the logical "Game Button 3" key on the keyboard.
  gameButton3,

  /// Represents the logical "Game Button 4" key on the keyboard.
  gameButton4,

  /// Represents the logical "Game Button 5" key on the keyboard.
  gameButton5,

  /// Represents the logical "Game Button 6" key on the keyboard.
  gameButton6,

  /// Represents the logical "Game Button 7" key on the keyboard.
  gameButton7,

  /// Represents the logical "Game Button 8" key on the keyboard.
  gameButton8,

  /// Represents the logical "Game Button 9" key on the keyboard.
  gameButton9,

  /// Represents the logical "Game Button 10" key on the keyboard.
  gameButton10,

  /// Represents the logical "Game Button 11" key on the keyboard.
  gameButton11,

  /// Represents the logical "Game Button 12" key on the keyboard.
  gameButton12,

  /// Represents the logical "Game Button 13" key on the keyboard.
  gameButton13,

  /// Represents the logical "Game Button 14" key on the keyboard.
  gameButton14,

  /// Represents the logical "Game Button 15" key on the keyboard.
  gameButton15,

  /// Represents the logical "Game Button 16" key on the keyboard.
  gameButton16,

  /// Represents the logical "Game Button A" key on the keyboard.
  gameButtonA,

  /// Represents the logical "Game Button B" key on the keyboard.
  gameButtonB,

  /// Represents the logical "Game Button C" key on the keyboard.
  gameButtonC,

  /// Represents the logical "Game Button Left 1" key on the keyboard.
  gameButtonLeft1,

  /// Represents the logical "Game Button Left 2" key on the keyboard.
  gameButtonLeft2,

  /// Represents the logical "Game Button Mode" key on the keyboard.
  gameButtonMode,

  /// Represents the logical "Game Button Right 1" key on the keyboard.
  gameButtonRight1,

  /// Represents the logical "Game Button Right 2" key on the keyboard.
  gameButtonRight2,

  /// Represents the logical "Game Button Select" key on the keyboard.
  gameButtonSelect,

  /// Represents the logical "Game Button Start" key on the keyboard.
  gameButtonStart,

  /// Represents the logical "Game Button Thumb Left" key on the keyboard.
  gameButtonThumbLeft,

  /// Represents the logical "Game Button Thumb Right" key on the keyboard.
  gameButtonThumbRight,

  /// Represents the logical "Game Button X" key on the keyboard.
  gameButtonX,

  /// Represents the logical "Game Button Y" key on the keyboard.
  gameButtonY,

  /// Represents the logical "Game Button Z" key on the keyboard.
  gameButtonZ,

  /// Represents the logical "Fn" key on the keyboard.
  fn,

  /// Represents the logical "Shift" key on the keyboard.
  ///
  /// This key represents the union of the keys {shiftLeft, shiftRight} when
  /// comparing keys. This key will never be generated directly, its main use is
  /// in defining key maps.
  shift,

  /// Represents the logical "Meta" key on the keyboard.
  ///
  /// This key represents the union of the keys {metaLeft, metaRight} when
  /// comparing keys. This key will never be generated directly, its main use is
  /// in defining key maps.
  meta,

  /// Represents the logical "Alt" key on the keyboard.
  ///
  /// This key represents the union of the keys {altLeft, altRight} when
  /// comparing keys. This key will never be generated directly, its main use is
  /// in defining key maps.
  alt,

  /// Represents the logical "Control" key on the keyboard.
  ///
  /// This key represents the union of the keys {controlLeft, controlRight} when
  /// comparing keys. This key will never be generated directly, its main use is
  /// in defining key maps.
  control,

  // Missing flutter keys.

  backtab,
  returnKey,
}
