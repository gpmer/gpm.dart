import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;
import 'package:args/args.dart';

import '../config.dart' as config;
import '../utils.dart' show isGitRepoDir;
import '../git-dir-config.dart' show gitDirParse;
import '../git-url-parse/git-url-parse.dart' show gitUrlParse;


class ImportCommand extends Command {
  final name = "import";
  final aliases = ['ip'];
  final description = "register a repository to GPM.";
  ArgResults argv = null;

  ImportCommand({ArgParser parser, List<String> arguments}) {
    parser.addOption(
        'all', help: "import all the repositories in the current directory into GPM");
    parser.addOption('force',
        abbr: 'f',
        help: "forced import, that mean you don't care the replace the old dir or not, just do it."
    );
    argv = parser.parse(arguments);
  }

  Future run() async {
    final String dir = argv.arguments[1];
    await _importOneDir(dir);
//    List<Directory> sources = await readdir(config.ROOT);
    print('run import command');
    print(argv.options.toList());
    if (argv.options.toSet().contains("all")) {
      print('all flag');
    }
  }
}

Future _importOneDir(String dirPath) async {
  final bool isGitRepo = await isGitRepoDir(path.join(dirPath));
  if (isGitRepo == false) return;
  final String gitUrl = await gitDirParse(path.join(dirPath, '.git'));
  final Map<String, dynamic> gitInfo = gitUrlParse(gitUrl);
  print(gitInfo);
  final map = new Map();
  map["href"] = gitUrl;
}