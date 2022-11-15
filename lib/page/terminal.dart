// ignore_for_file: non_constant_identifier_names

part of terminal_page;

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
              items: topBar(isHideWindowControll: widget.isHideWindowControll),
            ),
            Expanded(
              child: TerminalView(
                getTerminalNow.terminal,
                theme: TerminalThemes.defaultTheme,
                controller: getTerminalNow.terminalController,
                textScaleFactor:
                    (textScaleFactor < 0.1) ? 0.1 : textScaleFactor,
                autofocus: true,
                backgroundOpacity: 0,
                simulateScroll: true,
                padding: const EdgeInsets.all(5),
                alwaysShowCursor: true,
                onSecondaryTapDown: (details, offset) async {
                  final selection = getTerminalNow.terminalController.selection;
                  if (selection != null) {
                    final text =
                        getTerminalNow.terminal.buffer.getText(selection);
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
