import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;

class CleanCommand extends Command {
  final name = "clean";
  final aliases = ['cl'];
  final description = "clean the temp/cache.";
  var argv = null;

  CleanCommand(__argv) {
    argv = __argv;
  }

  Future run() async {
    await new Directory(config.TEMP).delete(recursive: true);

    Log.message('cache clean');
  }
}