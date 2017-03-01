import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';
import 'package:prompt/prompt.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readJson, removedir, writeJson;

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

    final allowed = repos.map((repo) {
      return repo["path"];
    }).toList();

    Log.message('You can Press [CTRL+C] to cancle this action.');

    final answer = await prompt.ask(
      new Question(
        'Switch one you want to remove, Enter the flowing Index', defaultsTo: allowed.first, allowed: allowed
      )
    );

    close();

    var target = null;
    repos.forEach((repo) {
      if (repo["path"] == answer) target = repo;
    });

    repos.remove(target);

    lock["repos"] = repos.toList();

    await writeJson(config.LOCK, lock);

    await removedir(target["path"]);

    Log.message('${target["path"]} has been remove');
  }
}