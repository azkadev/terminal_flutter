// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pty/flutter_pty.dart';
import 'package:general_flutter/general_flutter.dart';
import 'package:general_lib/general_lib.dart';
import 'package:general_lib_flutter/general_lib_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terminal_flutter/core/terminal_client.dart';
import 'package:terminal_flutter/package/package.dart';
import 'package:terminal_flutter/page/core.dart';
import 'package:terminal_flutter/page/terminal_flutter.dart';

import 'package:universal_io/io.dart';

enum LinuxDistroType {
  alpine,
  ubuntu,
}

class NewTerminalPage extends StatefulWidget {
  const NewTerminalPage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  NewTerminalPageState createState() => NewTerminalPageState();
}

class NewTerminalPageState extends State<NewTerminalPage> {
  TerminalFlutter terminalFlutter = TerminalFlutter();

  bool is_init_client = false;
  GeneralFlutter general_library = GeneralFlutter();
  // late ExplorerController explorerController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      task();
    });
  }

  VirtKeyProvider virtKeyProvider = VirtKeyProvider();

  TextInputType terminalKeyboardType = TextInputType.text;
  void task() {
    Future(() async {
      Directory directory = await getAppDir();
      

      Terminal terminal = Terminal(
        maxLines: 10000,
        inputHandler: virtKeyProvider,
      );

      await terminalFlutter.init(
        terminalLib: terminal,
        terminalControllerLib: TerminalController(),
        ptyLib: Pty.start(
          TerminalNativeShell.shell,
          // environment: () {

          //   ProcessResult processResult_whoami = Process.runSync("whoami", []);
          //   return {
          //     "USER": processResult_whoami.stdout.toString(),
          //   };
          // }(),
          workingDirectory: () {
            if (dart.isAndroid) {
              return directory.path;
            }
            return null;
          }(),
          columns: terminal.viewWidth,
          rows: terminal.viewHeight,
        ),
      );

      setState(() {
        is_init_client = true;
      });

      // ProcessResult processResult_whoami = Process.runSync("whoami", []);
      // terminal.textInput("login -f ${processResult_whoami.stdout.toString()}");
      // terminal.keyInput(TerminalKey.enter);
    });
  }

  addCommand() {}

  Future<Directory> getAppDir() async {
    return await getApplicationSupportDirectory();
  }

  @override
  void dispose() {
    terminalFlutter.pty.kill();
    super.dispose();
  }

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color.fromARGB(255, 41, 55, 69);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  GlobalKey globalKey = GlobalKey();

  String text_command_first = """
Welcome to Terminal!

Docs:       https://github.com/azkadev/terminal_flutter
Donate:     https://github.com/azkadev/terminal_flutter
Community:  https://github.com/azkadev/terminal_flutter

Working with packages:

 - Search:  apt search <query>
 - Install: apt install <package>
 - Upgrade: apt upgrade

Report issues at https://github.com/azkadev/terminal_flutter
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      appBar: PreferredSize(
        preferredSize: Size(
          context.width,
          450,
        ),
        child: Container(
          key: globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: context.mediaQueryData.padding.top,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.navigator().pop();
                    },
                    child: Icon(Iconsax.backward),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          terminalWidget(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: terminalBottom(),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true, // Tetapkan false untuk menghindari penggeseran layar ke atas
    );
  }

  Widget terminalWidget() {
    return Builder(
      builder: (context) {
        if (is_init_client == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 0,
            minWidth: 0,
            // maxHeight: context.height,
          ),
          child: Column(
            children: [
              SizedBox.fromSize(
                size: globalKey.sizeRenderBox(),
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  removeBottom: true,
                  removeLeft: true,
                  removeRight: true,
                  child: Builder(
                    builder: (context) {
                      //   bool is_explorer = false;
                      //   if (is_explorer) {
                      //     return Explorer(
                      //       controller: explorerController,

                      //       // Customize UI by Explorer & you own widgets!
                      //       builder: (_) => [
                      //         const ExplorerToolbar(),
                      //         const ExplorerActionView(),
                      //         const ExplorerFilesGridView(),
                      //       ],
                      //       // Callback called on file at explorer pressed
                      //       filePressed: (file) {
                      //         if ((file.size ?? 0) > 200000) {
                      //           final snackBar = const SnackBar(content: Text('Can\'t open files with size > 200kb'));

                      //           // Find the Scaffold in the widget tree and use it to show a SnackBar.
                      //           ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //           return;
                      //         }
                      //       },
                      //     );
                      //   }
                      //
                      //               TerminalView(
                      //   terminal,
                      //   controller: terminalController,
                      //   keyboardType: _keyboardType,
                      //   textStyle: terminalStyle,
                      //   theme: terminalTheme,
                      //   deleteDetection: isMobile,
                      //   autofocus: true,
                      //   keyboardAppearance: _isDark ? Brightness.dark : Brightness.light,
                      //   cursorType: _termCursor,
                      //   //hideScrollBar: false,
                      // ),
                      return TerminalView(
                        terminalFlutter.terminal,
                        theme: TerminalThemes.defaultTheme,
                        controller: terminalFlutter.terminalController,
                        keyboardType: terminalKeyboardType,
                        textScaler: TextScaler.linear((terminalFlutter.textScaleFactor < 0.1) ? 0.1 : terminalFlutter.textScaleFactor),
                        autofocus: true,
                        backgroundOpacity: 0,
                        simulateScroll: true,
                        padding: const EdgeInsets.all(5),
                        alwaysShowCursor: true,
                        deleteDetection: dart.isMobile,
                        onSecondaryTapDown: (details, offset) async {
                          final selection = terminalFlutter.terminalController.selection;
                          if (selection != null) {
                            final text = terminalFlutter.terminal.buffer.getText(selection);
                            terminalFlutter.terminalController.clearSelection();
                            await Clipboard.setData(ClipboardData(text: text));
                          } else {
                            final data = await Clipboard.getData('text/plain');
                            final text = data?.text;
                            if (text != null) {
                              terminalFlutter.terminal.paste(text);
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox.fromSize(
                size: globalKey_Bottom.sizeRenderBox(),
              ),
              // Flexible(child: terminalBottom()),
            ],
          ),
        );
      },
    );
  }

  ValueNotifier valueNotifier = ValueNotifier("");

  void writeLn(String text) {
    terminalFlutter.terminal.write('${text}\r\n');
  }

  GlobalKey globalKey_Bottom = GlobalKey();
  Widget terminalBottom() {
    return Container(
      key: globalKey_Bottom,
      height: _virtKeysHeight,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Builder(
        // valueListenable: valueNotifier,
        builder: (context) {
          List<Widget> children = terminalVirtualWidgets.map(
            (e) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: e.map((ee) {
                  return buildVirtualKeyItem(ee);
                }).toList(),
              );
            },
          ).toList();
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          );
        },
      ),
    );
  }

  void _initVirtKeys() {
    updateVirtualKey();
  }

  double _virtKeyWidth = 0;
  double _virtKeysHeight = 0;
  void updateVirtualKey() {
    if (dart.isAndroid) {
      _virtKeyWidth = context.mediaQueryData.size.width / 7;
      _virtKeysHeight = context.mediaQueryData.size.height * 0.043 * terminalVirtualWidgets.length;
    }
  } 
  Widget buildVirtualKeyItem(TerminalVirtualWidget terminalVirtualWidget) {
    return MaterialButton(
      onPressed: () {
        terminalVirtualWidget.onTap(context, terminalFlutter);
      },
      minWidth: 0,
      child: SizedBox(
        width: _virtKeyWidth,
        height: _virtKeysHeight / terminalVirtualWidgets.length,
        child: Center(
          child: terminalVirtualWidget.child,
        ),
      ),
    );
  }

  void handleTap({required FutureOr<dynamic> Function(BuildContext context) handleFunction}) {
    Future(() async {
      await handleFunction(context);
    });
  }

  List<List<TerminalVirtualWidget>> get terminalVirtualWidgets {
    return [
      [
        TerminalVirtualWidget(
          child: const Text("Tab"),
          onTap: (context, TerminalFlutter terminalFlutter) {
            setState(() {
              terminalFlutter.terminal.keyInput(TerminalKey.tab);
            });
          },
        ),
        TerminalVirtualWidget(
          child: const Icon(Icons.add),
          onTap: (context, TerminalFlutter terminalFlutter) {
            terminalFlutter.scaleUp();
            setState(() {});
          },
        ),
        TerminalVirtualWidget(
          child: const Icon(Icons.minimize),
          onTap: (context, TerminalFlutter terminalFlutter) {
            terminalFlutter.scaleDown();
            setState(() {});
          },
        ),
        TerminalVirtualWidget(
          child: const Icon(Icons.keyboard_arrow_up),
          onTap: (context, TerminalFlutter terminalFlutter) {
            terminalFlutter.terminal.keyInput(TerminalKey.arrowUp);
          },
        ),
      ],
      [
        TerminalVirtualWidget(
          child: const Text("CTRL"),
          onTap: (context, TerminalFlutter terminalFlutter) {
            setState(() {
              virtKeyProvider.ctrl = !virtKeyProvider.ctrl;
            });
          },
        ),
        TerminalVirtualWidget(
          child: const Text("New"),
          onTap: (context, TerminalFlutter terminalFlutter) {
            Future(() async {
              print(await getApplicationSupportDirectory());
            });
          },
        ),
        TerminalVirtualWidget(
          child: const Icon(Icons.keyboard_arrow_left),
          onTap: (context, TerminalFlutter terminalFlutter) {
            terminalFlutter.terminal.keyInput(TerminalKey.arrowLeft);
          },
        ),
        TerminalVirtualWidget(
          child: const Icon(Icons.keyboard_arrow_down),
          onTap: (context, TerminalFlutter terminalFlutter) {
            terminalFlutter.terminal.keyInput(TerminalKey.arrowDown);
          },
        ),
        TerminalVirtualWidget(
          child: const Icon(Icons.keyboard_arrow_right),
          onTap: (context, TerminalFlutter terminalFlutter) {
            terminalFlutter.terminal.keyInput(TerminalKey.arrowRight);
          },
        ),
      ]
    ];
  }
}

class TerminalVirtualWidget {
  Widget child;
  void Function(BuildContext context, TerminalFlutter terminalFlutter) onTap;
  TerminalVirtualWidget({
    required this.child,
    required this.onTap,
  });
}
