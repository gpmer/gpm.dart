import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readdir, isGitRepoDir, readJson, writeJson;
import '../git-dir-config.dart' show gitDirParse;
import '../git-url-parse/git-url-parse.dart' show gitUrlParse;

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

    var lock = await readJson(config.LOCK);

    var repos = new Set();

    while (sources.length != 0) {
      final source = sources.removeLast();
      final List<Directory> owners = await readdir(source.path);
      while (owners.length != 0) {
        final owner = owners.removeLast();
        final List<Directory> projects = await readdir(owner.path);
        while (projects.length != 0) {
          final project = projects.removeLast();
          if (await isGitRepoDir(project.path)) {
            final String gitUrl = await gitDirParse(path.join(project.path, '.git'));

            final Map<String, dynamic> gitInfo = gitUrlParse(gitUrl);

            gitInfo["path"] = project.path;

            repos.add(gitInfo);
            lock["repos"] = repos.toList();
            await writeJson(config.LOCK, lock);

            Log.message('${gitUrl} link to ${project.path}');
          }
        }
      }
    }

    Log.message('relink success');
  }
}