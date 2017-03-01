import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readdir;


class ListCommand extends Command {
  final name = "list";
  final abbr = 'ls';
  final description = "display the all repo.";
  var argv = null;

  ListCommand(__argv) {
    argv = __argv;
  }

  Future run() async {
    var list = {};

    (await readdir(config.ROOT)).forEach((FileSystemEntity source) async {
      if (!list[source]) list[source] = {};
      (await readdir(source.path)).forEach((FileSystemEntity owner) async {
        if (!list[source][owner]) list[source][owner] = {};
        (await readdir(owner.path)).forEach((FileSystemEntity project) {
          print(project.path);
          list[source][owner][project] = project;
        });
      });
    });


    Log.message('run list command');
  }
}