import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:log/log.dart';

import 'package:gpmx/config.dart' as config;
import 'package:gpmx/utils.dart' show isGitRepoDir;
import 'package:gpmx/git-dir-config.dart' show gitDirParse;
import 'package:git_url_parse/git-url-parse.dart' show gitUrlParse;

Future _importOneDir(String dirPath) async {
  final bool isGitRepo = await isGitRepoDir(path.join(dirPath));
  if (isGitRepo == false) return;
  final String gitUrl = await gitDirParse(path.join(dirPath, '.git'));
  final Map<String, dynamic> gitInfo = gitUrlParse(gitUrl);
  print(gitInfo);
  final map = new Map();
  map["href"] = gitUrl;
}

Future importHandler(Map argv, Map options) async {
  final String dir = argv["dir"];
  await _importOneDir(dir);
}