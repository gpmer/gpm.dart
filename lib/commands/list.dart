import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readdir, readJson;


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

    final lock = await readJson(config.LOCK);

    List repos = new List.from(lock["repos"]);

    if (repos.isEmpty) repos = new List();

    var output = {};

    repos.forEach((Map repo) {
      var source = repo["source"];
      var owner = repo["owner"];
      var name = repo["name"];
      var path = repo["path"];
      if (!output[source]) output[source] = {};
      if (!output[source][owner]) output[source][owner] = {};
      output[source][owner][name] = path;
    });

//    (await readdir(config.ROOT)).forEach((FileSystemEntity source) async {
//      if (!list[source]) list[source] = {};
//      (await readdir(source.path)).forEach((FileSystemEntity owner) async {
//        if (!list[source][owner]) list[source][owner] = {};
//        (await readdir(owner.path)).forEach((FileSystemEntity project) {
//          print(project.path);
//          list[source][owner][project] = project;
//        });
//      });
//    });

    print(new JsonEncoder.withIndent('  ').convert(output));

    Log.message('run list command');
  }
}