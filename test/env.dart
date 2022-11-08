import 'dart:convert';

void main() {
  List<String> datas = """
SHELL=/data/data/com.termux/files/usr/bin/bash
COLORTERM=truecolor
HISTCONTROL=ignoreboth
PREFIX=/data/data/com.termux/files/usr
TERMUX_IS_DEBUGGABLE_BUILD=0
TERMUX_MAIN_PACKAGE_FORMAT=debian
PWD=/data/data/com.termux/files/usr
TERMUX_VERSION=0.118.0
EXTERNAL_STORAGE=/sdcard
LD_PRELOAD=/data/data/com.termux/files/usr/lib/libtermux-exec.so
HOME=/data/data/com.termux/files/home
LANG=en_US.UTF-8
TERMUX_APK_RELEASE=F_DROID
DEX2OATBOOTCLASSPATH=/apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/core-icu4j.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/framework-atb-backward-compatibility.jar:/system/framework/qcom.fmradio.jar:/system/framework/QPerformance.jar:/system/framework/UxPerformance.jar:/system/framework/telephony-ext.jar:/system/framework/WfdCommon.jar
TMPDIR=/data/data/com.termux/files/usr/tmp
ANDROID_DATA=/data
TERM=xterm-256color
ANDROID_I18N_ROOT=/apex/com.android.i18n
SHLVL=1
ANDROID_ROOT=/system
BOOTCLASSPATH=/apex/com.android.art/javalib/core-oj.jar:/apex/com.android.art/javalib/core-libart.jar:/apex/com.android.art/javalib/core-icu4j.jar:/apex/com.android.art/javalib/okhttp.jar:/apex/com.android.art/javalib/bouncycastle.jar:/apex/com.android.art/javalib/apache-xml.jar:/system/framework/framework.jar:/system/framework/ext.jar:/system/framework/telephony-common.jar:/system/framework/voip-common.jar:/system/framework/ims-common.jar:/system/framework/framework-atb-backward-compatibility.jar:/system/framework/qcom.fmradio.jar:/system/framework/QPerformance.jar:/system/framework/UxPerformance.jar:/system/framework/telephony-ext.jar:/system/framework/WfdCommon.jar:/apex/com.android.conscrypt/javalib/conscrypt.jar:/apex/com.android.media/javalib/updatable-media.jar:/apex/com.android.mediaprovider/javalib/framework-mediaprovider.jar:/apex/com.android.os.statsd/javalib/framework-statsd.jar:/apex/com.android.permission/javalib/framework-permission.jar:/apex/com.android.sdkext/javalib/framework-sdkextensions.jar:/apex/com.android.wifi/javalib/framework-wifi.jar:/apex/com.android.tethering/javalib/framework-tethering.jar
ANDROID_TZDATA_ROOT=/apex/com.android.tzdata
TERMUX_APP_PID=13262
PATH=/data/data/com.termux/files/home/.pub-cache/bin:/data/data/com.termux/files/usr/bin
ANDROID_ART_ROOT=/apex/com.android.art
_=/data/data/com.termux/files/usr/bin/env
OLDPWD=/data/data/com.termux/files
"""
      .split("\n");
  late Map jsonData = {};
  for (var i = 0; i < datas.length; i++) {
    // ignore: non_constant_identifier_names
    String data = datas[i];
     
    print("export ${data.replaceAll(RegExp(r"/data/data/com.termux/",  caseSensitive: false), r"/data/data/com.example.terminal/")}");
    List<String> get_data = data.split("=");
    jsonData[get_data.first] = get_data.last;
  }
  // print(json.encode(jsonData));
}
