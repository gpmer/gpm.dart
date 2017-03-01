library gpm;

import 'dart:io';
import 'dart:async';

import 'package:args/args.dart' show ArgParser;
import 'package:args/command_runner.dart' show CommandRunner, UsageException;

import 'prepare.dart' show prepare;

// commands
import './commands/add.dart' show AddCommand;
import './commands/list.dart' show ListCommand;
import './commands/clean.dart' show CleanCommand;


Future main(List<String> arguments) async {
  final parser = new ArgParser();
  final argv = parser.parse(arguments);

  parser..addFlag('verbose', abbr: 'v')..addFlag(
    'iambic-pentameter', abbr: 'i');

  var runner = new CommandRunner("gpmx", "Git Package Manager, make you manage the repository easier.")
    ..addCommand(new ListCommand(argv))..addCommand(new AddCommand(argv))..addCommand(new CleanCommand(argv));

  await prepare();

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}

