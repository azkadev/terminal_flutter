library terminal_widget;

import 'dart:convert';
import 'dart:io';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:terminal_flutter/core/core.dart';
import 'package:xterm/xterm.dart';
import "package:iconsax/iconsax.dart";
part "header.dart";
part "window_controller.dart";


  
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