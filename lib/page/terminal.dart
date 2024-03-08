// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_lib/general_lib.dart';
import 'package:general_lib_flutter/general_lib_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terminal_flutter/core/core.dart';
import 'package:terminal_flutter/core/terminal_client.dart';
import 'package:terminal_flutter/page/setting.dart';
import 'package:xterm/xterm.dart';
import "package:path/path.dart" as path;

class TerminalPage extends StatefulWidget {
  final Directory? app_dir;
  final bool isHideWindowControll;
  const TerminalPage({
    super.key,
    required this.app_dir,
    this.isHideWindowControll = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  TerminalPageState createState() => TerminalPageState();
}

class TerminalPageState extends State<TerminalPage> {
  List<TerminalClient> terminalClients = [];
  bool is_init_client = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      task();
    });
  }

  void task() {
    Future(() async {
      Directory directory = await getAppDir();
      terminalClients = [
        TerminalClient(
          title: "Helo",
          terminal: Terminal(
            maxLines: 10000,
          ),
          terminalController: TerminalController(),
          workingDirectory: (dart.isAndroid) ? directory.path : null,
          isActive: true,
        )
      ];

      setState(() {
        is_init_client = true;
      });

      await extractBootStrap(
        directory: directory,
      );
    });
  }

  Future<void> extractBootStrap({
    required Directory directory,
  }) async {
    ByteData boot_strap = await rootBundle.load("assets/bootstrap/alpine-aarch64.zip");
    Archive archive = ZipDecoder().decodeBytes(boot_strap.buffer.asUint64List());
    Directory directory_boot_strap = Directory(path.join(directory.path, "linux"));
    if (dart.isAndroid) {
      addCommand(executable: "su", args: []);
    }

    if (directory_boot_strap.existsSync() == false) {
      extractArchiveToDisk(
        archive,
        directory_boot_strap.path,
      );

      if (dart.isAndroid) {
        // getTerminalNow.pty.write(utf8.encode("cd ${directory_boot_strap.path}\n"));

        // if (dart.isAndroid) {
        //   getTerminalNow.pty.write(utf8.encode("chmod -R 777 ${directory_boot_strap.path}\n"));
        //   getTerminalNow.pty.write(utf8.encode("chmod -R +rx ${directory_boot_strap.path}\n"));
        // }
      }
    }

    addCommand(executable: "cd", args: [
      directory_boot_strap.path,
    ]);
    addCommand(
      executable: "chmod",
      args: [
        "-R",
        "777",
        "*",
      ],
    );
    addCommand(
      executable: "chmod",
      args: [
        "-R",
        "+rx",
        "*",
      ],
    );

    Directory directory_bootstrap_linux = Directory(path.join(directory_boot_strap.path, "bootstrap"));
    if (directory_bootstrap_linux.existsSync() == false) {
      addCommand(
        executable: "./install-bootstrap.sh",
        args: [],
      );
    }

    addCommand(
      executable: "./run-bootstrap.sh",
      args: [
        "azka",
        "sh",
      ],
    );

    // addCommand(
    //   executable: "apk",
    //   args: [
    //     "update",
    //   ],
    // );

    // addCommand(
    //   executable: "apk",
    //   args: [
    //     "upgrade",
    //   ],
    // );
  }

  void addCommand({
    required String executable,
    required List<String> args,
  }) {
    getTerminalNow.pty.write(utf8.encode(
      [executable, ...args, "\n"].join(" "),
    ));
  }

  Future<Directory> getAppDir() async {
    return await getApplicationSupportDirectory();
  }

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color.fromARGB(255, 41, 55, 69);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  GlobalKey globalKey = GlobalKey();
  double textScaleFactor = 1;

  TerminalClient get getTerminalNow {
    return terminalClients.getTerminalActiveForce();
  }

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
    print("oe");
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
              // Header(
              //   color: currentColor,
              //   terminalClients: terminalClients,
              //   items: topBar(isHideWindowControll: widget.isHideWindowControll),
              // ),
            ],
          ),
        ),
      ),
      body: Builder(
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
                        TerminalClient terminal = getTerminalNow;
                        return TerminalView(
                          terminal.terminal,
                          theme: TerminalThemes.defaultTheme,
                          controller: terminal.terminalController,
                          textScaler: TextScaler.linear((textScaleFactor < 0.1) ? 0.1 : textScaleFactor),
                          autofocus: true,
                          backgroundOpacity: 0,
                          simulateScroll: true,
                          padding: const EdgeInsets.all(5),
                          alwaysShowCursor: true,
                          deleteDetection: true,
                          onSecondaryTapDown: (details, offset) async {
                            final selection = terminal.terminalController.selection;
                            if (selection != null) {
                              final text = terminal.terminal.buffer.getText(selection);
                              terminal.terminalController.clearSelection();
                              await Clipboard.setData(ClipboardData(text: text));
                            } else {
                              final data = await Clipboard.getData('text/plain');
                              final text = data?.text;
                              if (text != null) {
                                terminal.terminal.paste(text);
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void scaleDown() {
    double res = textScaleFactor - 0.2;
    if (res < 0.1) {
      return;
    }

    setState(() {
      textScaleFactor = res;
    });
  }

  void scaleUp() {
    setState(() {
      textScaleFactor = (textScaleFactor + 0.2);
    });
  }

  List<Widget> topBar({
    bool isHideWindowControll = false,
  }) {
    List<Widget> setting = [
      MaterialButton(
        minWidth: 0,
        onPressed: () {
          scaleDown();
        },
        hoverColor: const Color.fromARGB(255, 63, 63, 63),
        child: const Icon(
          Iconsax.minus,
          color: Colors.white,
        ),
      ),
      MaterialButton(
        minWidth: 0,
        onPressed: () {
          scaleUp();
        },
        hoverColor: const Color.fromARGB(255, 63, 63, 63),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      MaterialButton(
        minWidth: 0,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const SettingPage();
            }),
          );
          return;
          // return await showDialog(
          //   builder: (context) {
          //     return AlertDialog(
          //       title: const Text('Pick a color!'),
          //       content: SingleChildScrollView(
          //         child: ColorPicker(
          //           pickerColor: pickerColor,
          //           onColorChanged: changeColor,
          //         ),
          //       ),
          //       actions: [
          //         ElevatedButton(
          //           child: const Text('Got it'),
          //           onPressed: () {
          //             setState(() => currentColor = pickerColor);
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //       ],
          //     );
          //   },
          //   context: context,
          // );
        },
        hoverColor: const Color.fromARGB(255, 63, 63, 63),
        child: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    ];

    if (!isDesktop) {
      return setting;
    }
    if (isHideWindowControll) {
      return setting;
    }
    return [
      ...setting,
    ];
  }
}
