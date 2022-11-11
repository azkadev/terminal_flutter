// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

part of terminal_page;

class SettingPage extends StatefulWidget {
  final Directory app_dir;
  const SettingPage({
    super.key,
    required this.app_dir,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentColor,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0,
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  minWidth: MediaQuery.of(context).size.width * 1 / 5,
                  maxWidth: MediaQuery.of(context).size.width * 1 / 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderApp(
                      color: currentColor,
                      height: 40,
                      items: const [],
                      isShowWindowController: false,
                      children: [
                        Row(
                          children: [
                            MaterialButton(
                              minWidth: 0,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              hoverColor: const Color.fromARGB(255, 63, 63, 63),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    MaterialButton(
                      minWidth: 0,
                      onPressed: () {},
                      hoverColor: const Color.fromARGB(255, 63, 63, 63),
                      child: ListTile(
                        leading: Icon(
                          Iconsax.information,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Theme",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      minWidth: 0,
                      onPressed: () {},
                      hoverColor: const Color.fromARGB(255, 63, 63, 63),
                      child: ListTile(
                        leading: Icon(
                          Iconsax.information,
                          color: Colors.white,
                        ),
                        title: Text(
                          "About",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 0.5,
              color: Colors.black,
            ),
            Expanded(
              flex: 5,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Column(
                  children: [
                    HeaderApp(
                      color: currentColor,
                      height: 40,
                      items: const [],
                      isShowWindowController: false,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Activify",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            children: topBar(),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> topBar() {
    List<Widget> setting = [];
    if (!isDesktop) {
      return setting;
    }
    return [...setting, ...windowController()];
  }
}
