import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readdir, readJson;


class ListCommand extends Command {
  final name = "list";
  final aliases = ['ls'];
  final description = "display the all repo.";
  var argv = null;

  ListCommand(__argv) {
    argv = __argv;
  }

  Future run() async {

    final lock = await readJson(config.LOCK);

    List repos = new List.from(lock["repos"]);

    if (repos.isEmpty) repos = new List();

    var output = new Map();

    while (repos.length != 0) {
      Map repo = repos.removeLast();
      String source = repo["source"];
      String owner = repo["owner"];
      String name = repo["name"];
      String path = repo["path"];
      Map<String, dynamic> sourceMap = output.containsKey(source) ? output[source] : new Map();
      Map<String, dynamic> ownerMap = sourceMap.containsKey(owner) ? sourceMap[owner] : new Map();
      ownerMap[name] = path;
      sourceMap[owner] = ownerMap;

      output[source] = sourceMap;
    }

    print(new JsonEncoder.withIndent('  ').convert(output));

    Log.message('run list command');
  }
}