// ignore_for_file: non_constant_identifier_names

part of terminal_page;

final buttonColors = WindowButtonColors(
  iconNormal: const Color.fromARGB(255, 255, 255, 255),
  mouseOver: const Color.fromARGB(255, 63, 63, 63),
  mouseDown: const Color.fromARGB(255, 255, 255, 255),
  iconMouseOver: const Color.fromARGB(255, 255, 255, 255),
  iconMouseDown: const Color.fromARGB(255, 255, 255, 255),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color.fromARGB(255, 255, 255, 255),
  mouseDown: const Color.fromARGB(255, 255, 255, 255),
  iconNormal: const Color.fromARGB(255, 255, 255, 255),
  iconMouseOver: const Color.fromARGB(255, 255, 0, 0),
);

class TerminalPage extends StatefulWidget {
  final Directory app_dir;
  const TerminalPage({
    super.key,
    required this.app_dir,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TerminalPageState createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  late List<TerminalClient> terminalClients = [
    TerminalClient(
      title: "Helo",
      terminal: Terminal(
        maxLines: 10000,
      ),
      terminalController: TerminalController(),
      isActive: true,
    )
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) {
          TerminalClient terminalClient = getTerminalNow;
          setState(() {});

          String text = """
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
          terminalClient.terminal.write(text.split("\n").join("\t"));

          return;
        }
      },
    );
  }

  String? getAppDir() {
    if (!isDesktop) {
      return widget.app_dir.path;
    }
    return null;
  }

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color.fromARGB(255, 41, 55, 69);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  late double textScaleFactor = 1;

  TerminalClient get getTerminalNow {
    return terminalClients.getTerminalActiveForce();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      body: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 0,
        ),
        child: Column(
          children: [
            Header(
              color: currentColor,
              terminalClients: terminalClients,
              items: topBar(),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 30,
            //   decoration: BoxDecoration(
            //     color: currentColor,
            //   ),
            //   clipBehavior: Clip.antiAlias,
            //   child: MoveWindow(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Flexible(
            //                 child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   primary: false,
            //                   shrinkWrap: true,
            //                   itemCount: terminalClients.length,
            //                   itemBuilder: (context, index) {
            //                     TerminalClient terminalClient = terminalClients[index];
            //                     return Padding(
            //                       padding: const EdgeInsets.all(2),
            //                       child: Container(
            //                         height: 20,
            //                         width: 150,
            //                         decoration: const BoxDecoration(
            //                           color: Color.fromARGB(255, 255, 255, 255),
            //                           borderRadius: BorderRadius.all(
            //                             Radius.circular(5),
            //                           ),
            //                           boxShadow: [
            //                             BoxShadow(
            //                               color: Colors.black12,
            //                               spreadRadius: 0,
            //                               blurRadius: 5,
            //                             ),
            //                             BoxShadow(
            //                               color: Colors.black12,
            //                               spreadRadius: 0,
            //                               blurRadius: 5,
            //                             ),
            //                             BoxShadow(
            //                               color: Colors.black12,
            //                               spreadRadius: 0,
            //                               blurRadius: 5,
            //                             ),
            //                           ],
            //                         ),
            //                         child: MaterialButton(
            //                           minWidth: 0,
            //                           onPressed: () {
            //                             setState(() {
            //                               terminalClients.setInactiveAll();
            //                               terminalClients[index].isActive = true;
            //                             });
            //                           },
            //                           hoverColor: const Color.fromARGB(255, 63, 63, 63),
            //                           child: Row(
            //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Padding(
            //                                 padding: const EdgeInsets.all(2),
            //                                 child: Text(
            //                                   index.toString(),
            //                                 ),
            //                               ),
            //                               Flexible(
            //                                 child: Padding(
            //                                   padding: const EdgeInsets.all(2),
            //                                   child: Text(
            //                                     terminalClient.title,
            //                                     overflow: TextOverflow.ellipsis,
            //                                   ),
            //                                 ),
            //                               ),
            //                               MaterialButton(
            //                                 minWidth: 0,
            //                                 onPressed: () {
            //                                   terminalClients.close(index: index);
            //                                   setState(() {
            //                                     if (terminalClients.isEmpty) {
            //                                       terminalClients.getTerminalActiveForce();
            //                                     }
            //                                   });
            //                                 },
            //                                 child: const Icon(
            //                                   Icons.close,
            //                                   color: Colors.black,
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //               MaterialButton(
            //                 minWidth: 0,
            //                 onPressed: () {
            //                   setState(() {
            //                     terminalClients.initNew();
            //                   });
            //                 },
            //                 hoverColor: const Color.fromARGB(255, 63, 63, 63),
            //                 child: const Icon(
            //                   Icons.add,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           // ignore: prefer_const_constructors
            //           padding: EdgeInsets.only(left: 15),
            //           child: Row(
            //             children: topBar(),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: TerminalView(
                getTerminalNow.terminal,
                theme: TerminalThemes.defaultTheme,
                controller: getTerminalNow.terminalController,
                textScaleFactor: (textScaleFactor < 0.1)?0.1:textScaleFactor,
                autofocus: true,
                backgroundOpacity: 0,
                simulateScroll: true,
                padding: const EdgeInsets.all(5),
                alwaysShowCursor: true,
                onSecondaryTapDown: (details, offset) async {
                  final selection = getTerminalNow.terminalController.selection;
                  if (selection != null) {
                    final text = getTerminalNow.terminal.buffer.getText(selection);
                    getTerminalNow.terminalController.clearSelection();
                    await Clipboard.setData(ClipboardData(text: text));
                  } else {
                    final data = await Clipboard.getData('text/plain');
                    final text = data?.text;
                    if (text != null) {
                      getTerminalNow.terminal.paste(text);
                    }
                  }
                },
              ),
            ),
          ],
        ),
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

  List<Widget> topBar() {
    List<Widget> setting = [
      MaterialButton(
        minWidth: 0,
        onPressed: () {
          scaleDown();
        },
        hoverColor: const Color.fromARGB(255, 63, 63, 63),
        child: MinimizeIcon(
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
              return SettingPage(
                app_dir: widget.app_dir,
              );
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
    return [
      ...setting,
      MinimizeWindowButton(colors: buttonColors),
      MaximizeWindowButton(colors: buttonColors),
      CloseWindowButton(
        colors: closeButtonColors,
      ),
    ];
  }

}
