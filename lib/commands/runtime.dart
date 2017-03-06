import 'dart:io' show Platform;
import 'dart:async';

import 'package:log/log.dart';

Future runtimeHandler(Map argv, Map options) async {
  Log.message('Your runtime infomation:\n');

  print("""
isAndroid: ${Platform.isAndroid}
isLinux: ${Platform.isLinux}
isIOS: ${Platform.isIOS}
isMacOS: ${Platform.isMacOS}
isWindows: ${Platform.isWindows}
platform: ${Platform.operatingSystem}
dart: ${Platform.version}
    """);
}