library gpmx;

import 'dart:io';
import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart' show CommandRunner, UsageException;

import 'prepare.dart' show prepare;

// commands
import './commands/add.dart' show AddCommand;
import './commands/list.dart' show ListCommand;
import './commands/clean.dart' show CleanCommand;
import './commands/runtime.dart' show RuntimeCommand;
import './commands/remove.dart' show RemoveCommand;
import './commands/relink.dart' show RelinkCommand;
import './commands/import.dart' show ImportCommand;


Future bootstrap(List<String> arguments) async {
  final ArgParser parser = new ArgParser();
  final ArgResults argv = parser.parse(arguments);

  parser.addFlag('verbose', abbr: 'v');
  parser.addFlag('help', abbr: 'i');

  final program = new CommandRunner("gpmx", "Git Package Manager, make you manage the repository easier.");

  program.addCommand(new ListCommand(arguments));
  program.addCommand(new AddCommand(arguments));
  program.addCommand(new CleanCommand(arguments));
  program.addCommand(new RuntimeCommand(arguments));
  program.addCommand(new RemoveCommand(arguments));
  program.addCommand(new RelinkCommand(arguments));
  program.addCommand(new ImportCommand(arguments: arguments, parser: parser));

  await prepare();

  program.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}