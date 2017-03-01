import 'dart:io' show Platform;
import 'dart:async';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

class RuntimeCommand extends Command {
  final name = "runtime";
  final abbr = 'rt';
  final description = "print the program runtime, useful for submit a issue.";
  var argv = null;

  RuntimeCommand(__argv) {
    argv = __argv;
  }

  Future run() async {
    Log.message('Your run time:\n');

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
}