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
import './commands/runtime.dart' show RuntimeCommand;
import './commands/remove.dart' show RemoveCommand;
import './commands/relink.dart' show RelinkCommand;


Future bootstrap(List<String> arguments) async {
  final parser = new ArgParser();
  final argv = parser.parse(arguments);

  parser.addFlag('verbose', abbr: 'v');
  parser.addFlag('help', abbr: 'i');

  final program = new CommandRunner("gpmx", "Git Package Manager, make you manage the repository easier.");

  program.addCommand(new ListCommand(argv));
  program.addCommand(new AddCommand(argv));
  program.addCommand(new CleanCommand(argv));
  program.addCommand(new RuntimeCommand(argv));
  program.addCommand(new RemoveCommand(argv));
  program.addCommand(new RelinkCommand(argv));

  await prepare();

  program.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}