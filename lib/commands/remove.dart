import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readJson;

class RemoveCommand extends Command {
  final name = "remove";
  final abbr = 'rm';
  final description = "remove a repo.";
  var argv = null;

  RemoveCommand(__argv) {
    argv = __argv;
  }

  Future run() async {
    final lock = await readJson(config.LOCK);

    Set repos = new Set.from(lock["repos"]);
    if (repos.isEmpty) repos = new Set();

    int index = 0;

    repos.forEach((repo) {
      print('${index.toString()}: ${repo["path"]}');
      index++;
    });

    Log.message('print done');
  }
}