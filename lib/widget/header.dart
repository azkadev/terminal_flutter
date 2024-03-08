 

import 'package:flutter/material.dart';
import 'package:terminal_flutter/core/core.dart';
import 'package:terminal_flutter/core/terminal_client.dart';
import 'package:terminal_flutter/widget/window_controller.dart';

class Header extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final List<TerminalClient> terminalClients;
  final List<Widget> items;
  final bool isShowWindowController;
  const Header({
    super.key,
    this.padding,
    required this.color,
    required this.terminalClients,
    required this.items,
    this.isShowWindowController = false,
  });

  @override
  State<Header> createState() => _HeaderApp();
}

class _HeaderApp extends State<Header> {
  EdgeInsetsGeometry getPadding() {
    if (widget.padding == null) {
      if (!isDesktop) {
        return const EdgeInsets.only(top: 50);
      }
    }

    return widget.padding ?? const EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 30,
        decoration: BoxDecoration(
          color: widget.color,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: widget.terminalClients.length,
                      itemBuilder: (context, index) {
                        TerminalClient terminalClient =
                            widget.terminalClients[index];
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            height: 20,
                            width: 150,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              minWidth: 0,
                              onPressed: () {
                                setState(() {
                                  widget.terminalClients.setInactiveAll();
                                  widget.terminalClients[index].isActive = true;
                                });
                              },
                              hoverColor: const Color.fromARGB(255, 63, 63, 63),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.all(2),
                                  //   child: Text(
                                  //     index.toString(),
                                  //   ),
                                  // ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        terminalClient.title,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    minWidth: 0,
                                    onPressed: () {
                                      widget.terminalClients
                                          .close(index: index);
                                      setState(() {
                                        if (widget.terminalClients.isEmpty) {
                                          widget.terminalClients
                                              .getTerminalActiveForce();
                                        }
                                      });
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () {
                      setState(() {
                        widget.terminalClients.initNew();
                      });
                    },
                    hoverColor: const Color.fromARGB(255, 63, 63, 63),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: topBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> topBar() {
    if (!isDesktop) {
      return widget.items;
    }
    if (!widget.isShowWindowController) {
      return widget.items;
    }
    return [...widget.items, ...windowController()];
  }
}

class HeaderApp extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final Color? color;

  final List<Widget> items;
  final bool isShowWindowController;
  final List<Widget> children;
  final double height;
  const HeaderApp({
    super.key,
    this.padding,
    required this.color,
    required this.items,
    this.isShowWindowController = false,
    this.children = const <Widget>[],
    this.height = 30,
  });

  @override
  State<HeaderApp> createState() => _HeaderAppState();
}

class _HeaderAppState extends State<HeaderApp> {
  EdgeInsetsGeometry getPadding() {
    if (widget.padding == null) {
      if (!isDesktop) {
        return const EdgeInsets.only(top: 50);
      }
    }

    return widget.padding ?? const EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: widget.children,
        ),
      ),
    );
  }

  List<Widget> topBar() {
    if (!isDesktop) {
      return widget.items;
    }
    if (!widget.isShowWindowController) {
      return widget.items;
    }
    return [...widget.items, ...windowController()];
  }
}
