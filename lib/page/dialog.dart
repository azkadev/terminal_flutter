import 'package:flutter/material.dart';
import 'package:general_lib_flutter/general_lib_flutter.dart';
import 'package:terminal_flutter/page/terminal_flutter.dart';

class DialogList extends StatelessWidget {
  final TerminalFlutter terminalFlutter;
  const DialogList({
    super.key,
    required this.terminalFlutter,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogTitle(context),
          Flexible(
            child: _buildDialogList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }

  Widget _buildDialogList(BuildContext context) {
    List<DialogItemData> items = dialogItemDatas;
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].title),
          onTap: () {
            for (var i = 0; i < items[index].commands.length; i++) {
              terminalFlutter.terminal.textInput("${items[index].commands[i].trim()}\n");
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  List<DialogItemData> get dialogItemDatas {
    return [
      DialogItemData(
        title: "Setup Ubuntu Android",
        commands: [
          "DEBIAN_FRONTEND=noninteractive apt-get update -y",
          "DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils curl iperf dialog locales software-properties-common ca-certificates curl gnupg lsb-release",
        ],
      ),
      DialogItemData(
        title: "Install Neofetch",
        commands: [
          "DEBIAN_FRONTEND=noninteractive apt-get install -y neofetch",
          "neofetch"
        ],
      ),
    ];
  }
}

class DialogItemData {
  String title;

  List<String> commands;

  DialogItemData({
    required this.title,
    required this.commands,
  });
}
