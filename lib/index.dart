// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file

// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This is an example of converting the args in test.dart to use this API.
/// It shows what it looks like to build an [ArgParser] and then, when the code
/// is run, demonstrates what the generated usage text looks like.
library example;

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:log/log.dart';
import 'package:args/args.dart' show ArgParser;
import 'package:args/command_runner.dart'
    show CommandRunner, Command, UsageException;
import 'package:path/path.dart' as path;

import 'config.dart';
import 'utils.dart' show readdir, ensuredir, ensurefile;
import 'git-url-parse.dart' show gitUrlParse;

var argResults = [];

Future main(List<String> arguments) async {
  var parser = new ArgParser();

  parser..addFlag('verbose', abbr: 'v')..addFlag(
      'iambic-pentameter', abbr: 'i');

  var runner = new CommandRunner(
      "gpm", "Git Package Manager, make you manage the repository easier.")
    ..addCommand(new ListCommand())..addCommand(new AddCommand());

  argResults = parser.parse(arguments);

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}

class ListCommand extends Command {
  final name = "list";
  final abbr = 'ls';
  final description = "display the all repo.";

  CommitCommand() {
    argParser.addFlag('all', abbr: 'a');
  }

  Future run() async {
    var list = {};
    (await readdir(config["paths"]["root"])).forEach((FileSystemEntity source) async {
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

class AddCommand extends Command {
  final name = "add";
  final abbr = 'a';
  final description = "clone repo into local dir.";

  CommitCommand() {
    argParser.addFlag('all', abbr: 'a');
  }

  Future run() async {
    final repository = argResults.arguments[1];

    final gitInfo = gitUrlParse(repository);

    await ensuredir(path.join(config["paths"]["root"], gitInfo["resource"]));
    await ensuredir(path.join(config["paths"]["root"], gitInfo["resource"], gitInfo["owner"]));
    await ensuredir('./.__temp__');

    final Process process = await Process.start('git', ['clone', repository], workingDirectory: './.__temp__');

    process.stdout
        .transform(UTF8.decoder)
        .listen((data) {
      print(data);
    });

    process.stderr
        .transform(UTF8.decoder)
        .listen((data) {
      print(data);
    });
  }
}