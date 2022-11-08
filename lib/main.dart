// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pty/flutter_pty.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xterm/xterm.dart';

class AppPlatformMenu extends StatefulWidget {
  const AppPlatformMenu({super.key, required this.child});

  final Widget child;

  @override
  State<AppPlatformMenu> createState() => _AppPlatformMenuState();
}

class _AppPlatformMenuState extends State<AppPlatformMenu> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform != TargetPlatform.macOS) {
      return widget.child;
    }

    return PlatformMenuBar(
      menus: <MenuItem>[
        PlatformMenu(
          label: 'TerminalStudio',
          menus: [
            if (PlatformProvidedMenuItem.hasMenu(
              PlatformProvidedMenuItemType.about,
            ))
              const PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.about,
              ),
            PlatformMenuItemGroup(
              members: [
                if (PlatformProvidedMenuItem.hasMenu(
                  PlatformProvidedMenuItemType.servicesSubmenu,
                ))
                  const PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.servicesSubmenu,
                  ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                if (PlatformProvidedMenuItem.hasMenu(
                  PlatformProvidedMenuItemType.hide,
                ))
                  const PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.hide,
                  ),
                if (PlatformProvidedMenuItem.hasMenu(
                  PlatformProvidedMenuItemType.hideOtherApplications,
                ))
                  const PlatformProvidedMenuItem(
                    type: PlatformProvidedMenuItemType.hideOtherApplications,
                  ),
              ],
            ),
            if (PlatformProvidedMenuItem.hasMenu(
              PlatformProvidedMenuItemType.quit,
            ))
              const PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.quit,
              ),
          ],
        ),
        PlatformMenu(
          label: 'Edit',
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Copy',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyC,
                    meta: true,
                  ),
                  onSelected: () {
                    final primaryContext = primaryFocus?.context;
                    if (primaryContext == null) {
                      return;
                    }
                    Actions.invoke(
                      primaryContext,
                      CopySelectionTextIntent.copy,
                    );
                  },
                ),
                PlatformMenuItem(
                  label: 'Paste',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyV,
                    meta: true,
                  ),
                  onSelected: () {
                    final primaryContext = primaryFocus?.context;
                    if (primaryContext == null) {
                      return;
                    }
                    Actions.invoke(
                      primaryContext,
                      const PasteTextIntent(SelectionChangedCause.keyboard),
                    );
                  },
                ),
                PlatformMenuItem(
                  label: 'Select All',
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyA,
                    meta: true,
                  ),
                  onSelected: () {
                    final primaryContext = primaryFocus?.context;
                    if (primaryContext == null) {
                      return;
                    }
                    print(primaryContext);
                    try {
                      final action = Actions.maybeFind<Intent>(
                        primaryContext,
                        intent: const SelectAllTextIntent(
                          SelectionChangedCause.keyboard,
                        ),
                      );
                      print('action: $action');
                    } catch (e) {
                      print(e);
                    }
                    Actions.invoke<Intent>(
                      primaryContext,
                      const SelectAllTextIntent(SelectionChangedCause.keyboard),
                    );
                  },
                ),
              ],
            ),
            if (PlatformProvidedMenuItem.hasMenu(
              PlatformProvidedMenuItemType.quit,
            ))
              const PlatformProvidedMenuItem(
                type: PlatformProvidedMenuItemType.quit,
              ),
          ],
        ),
      ],
      child: widget.child,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory app_dir = await getApplicationSupportDirectory();

  runApp(MyApp(
    app_dir: app_dir,
  ));
}

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

class MyApp extends StatelessWidget {
  final Directory app_dir;
  const MyApp({
    super.key,
    required this.app_dir,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xterm.dart demo',
      debugShowCheckedModeBanner: false,
      home: AppPlatformMenu(
        child: Home(
          app_dir: app_dir,
        ),
      ),
      // shortcuts: ,
    );
  }
}

class Home extends StatefulWidget {
  final Directory app_dir;
  const Home({
    super.key,
    required this.app_dir,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final terminal = Terminal(
    maxLines: 10000,
  );

  final terminalController = TerminalController();

  late final Pty pty;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) _startPty();
      },
    );
  }

  String? getAppDir() {
    if (Platform.isAndroid || Platform.isIOS) {
      return widget.app_dir.path;
    }
    return null;
  }

  Map<String, String>? getEnv() {
    String? get_app_path = getAppDir();
    if (get_app_path == null) {
      return null;
    }
    return {
      "SHELL": "${get_app_path}/files/usr/bin/bash",
      "COLORTERM": "truecolor",
      "HISTCONTROL": "ignoreboth",
      "PREFIX": "${get_app_path}/files/usr",
      "TERMUX_IS_DEBUGGABLE_BUILD": "0",
      "TERMUX_MAIN_PACKAGE_FORMAT": "debian",
      "PWD": "${get_app_path}/files/usr",
      "TERMUX_VERSION": "0.118.0",
      "EXTERNAL_STORAGE": "/sdcard",
      "LD_PRELOAD": "${get_app_path}/files/usr/lib/libtermux-exec.so",
      "HOME": "${get_app_path}/files/home",
      "LANG": "en_US.UTF-8",
      "TERMUX_APK_RELEASE": "F_DROID",
      "DEX2OATBOOTCLASSPATH": "/apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/core-icu4j.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/framework-atb-backward-compatibility.jar:/system/framework/qcom.fmradio.jar:/system/framework/QPerformance.jar:/system/framework/UxPerformance.jar:/system/framework/telephony-ext.jar:/system/framework/WfdCommon.jar",
      "TMPDIR": "${get_app_path}/files/usr/tmp",
      "ANDROID_DATA": "/data",
      "TERM": "xterm-256color",
      "ANDROID_I18N_ROOT": "/apex/com.android.i18n",
      "SHLVL": "1",
      "ANDROID_ROOT": "/system",
      "BOOTCLASSPATH": "/apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/core-icu4j.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/framework-atb-backward-compatibility.jar:/system/framework/qcom.fmradio.jar:/system/framework/QPerformance.jar:/system/framework/UxPerformance.jar:/system/framework/telephony-ext.jar:/system/framework/WfdCommon.jar:/apex/com.android.conscrypt/javalib/conscrypt.jar:/apex/com.android.media/javalib/updatable-media.jar:/apex/com.android.mediaprovider/javalib/framework-mediaprovider.jar:/apex/com.android.os.statsd/javalib/framework-statsd.jar:/apex/com.android.permission/javalib/framework-permission.jar:/apex/com.android.sdkext/javalib/framework-sdkextensions.jar:/apex/com.android.wifi/javalib/framework-wifi.jar:/apex/com.android.tethering/javalib/framework-tethering.jar",
      "ANDROID_TZDATA_ROOT": "/apex/com.android.tzdata",
      "TERMUX_APP_PID": "13262",
      "PATH": "${get_app_path}/files/home/.pub-cache/bin:${get_app_path}/files/usr/bin",
      "ANDROID_ART_ROOT": "/apex/com.android.art",
      "_": "${get_app_path}/files/usr/bin/env",
      "OLDPWD": "${get_app_path}/files",
    };
  }

  void _startPty() {
    pty = Pty.start(
      shell,
      workingDirectory: getAppDir(),
      environment: getEnv(),
      columns: terminal.viewWidth,
      rows: terminal.viewHeight,
    );

    pty.output.cast<List<int>>().transform(const Utf8Decoder()).listen(terminal.write);

    pty.exitCode.then((code) {
      terminal.write('the process exited with exit code $code');
    });

    terminal.onOutput = (String data) {
      pty.write(const Utf8Encoder().convert(data));
    };

    terminal.onResize = (w, h, pw, ph) {
      pty.resize(h, w);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TerminalView(
        terminal,
        controller: terminalController,
        autofocus: true,
        backgroundOpacity: 0.7,
        simulateScroll: true,
        padding: const EdgeInsets.all(5),
        onSecondaryTapDown: (details, offset) async {
          final selection = terminalController.selection;
          if (selection != null) {
            final text = terminal.buffer.getText(selection);
            terminalController.clearSelection();
            await Clipboard.setData(ClipboardData(text: text));
          } else {
            final data = await Clipboard.getData('text/plain');
            final text = data?.text;
            if (text != null) {
              terminal.paste(text);
            }
          }
        },
      ),
    );
  }

  String get shell {
    if (Platform.isMacOS || Platform.isLinux) {
      return Platform.environment['SHELL'] ?? 'bash';
    }

    if (Platform.isWindows) {
      return 'cmd.exe';
    }
    String? get_app_path = getAppDir();
    if (get_app_path != null) {
      return "${get_app_path}/files/usr/bin/bash";
    }

    return 'sh';
  }
}
