import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readdir, isGitRepoDir;

class RelinkCommand extends Command {
  final name = "relink";
  final aliases = ['rl'];
  final description = "relink the base dir which contain repositories if you delete repository manually.";
  var argv = null;

  RelinkCommand(__argv) {
    argv = __argv;
  }

  Future run() async {
    final List<Directory> sources = await readdir(config.ROOT);

    var repos = [];

    sources.forEach((source) async {
      final List<Directory> owners = await readdir(source.path);
      owners.forEach((owner) async {
        final List<Directory> projects = await readdir(owner.path);
        projects.forEach((project) {
          repos.add(project.path);
          print(project.path);
        });
      });
    });

    Log.message('relink success');
  }
}