import 'dart:io';
import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:log/log.dart';

import '../config.dart' as config;
import '../utils.dart' show readdir, isGitRepoDir, readJson, writeJson;
import '../git-dir-config.dart' show gitDirParse;
import 'package:git_url_parse/git-url-parse.dart' show gitUrlParse;

Future relinkHandler(Map argv, Map options) async {
  final List<Directory> sources = await readdir(config.ROOT);

  var lock = await readJson(config.LOCK);

  var repositories = new Set();

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

          repositories.add(gitInfo);
          lock["repos"] = repositories.toList();
          await writeJson(config.LOCK, lock);

          Log.message('${gitUrl} link to ${project.path}');
        }
      }
    }
  }

  Log.message('relink success');
}