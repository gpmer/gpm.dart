library gpmx;

import 'dart:io';
import 'dart:async';

import 'package:escli/escli.dart' show program;
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
import './commands/import.dart' show ImportCommand;

Future bootstrap(List<String> arguments) async {
  program
    ..name('gpmx')
    ..description('Git Package Manager, make you manage the repository easier, Power by Dart')
    ..usage('<command> [options]');

  program
    .command('list', 'display the all repo.')
    .action((Map argv, Map options) {
    print('run list command');
  });

  program
    .command('add <repo>', 'clone repo into local dir.')
    .action((Map argv, Map options) {
    print('run add command');
  });

  program
    .command('remove', 'remove a repo.')
    .action((Map argv, Map options) {
    print('run remove command');
  });

  program
    .command('clean', 'clean the temp/cache.')
    .action((Map argv, Map options) {
    print('run clean command');
  });

  program
    .command('runtime', 'print the program runtime, useful for submit a issue.')
    .action((Map argv, Map options) {
    print('run runtime command');
  });

  program
    .command('relink', 'relink the base dir which contain repositories if you delete repository manually.')
    .action((Map argv, Map options) {
    print('run relink command');
  });

  program.parseArgv(arguments);

//  final parser = new ArgParser();
//  final argv = parser.parse(arguments);
//
//  parser.addFlag('verbose', abbr: 'v');
//  parser.addFlag('help', abbr: 'i');
//
//  final program = new CommandRunner("gpmx", "Git Package Manager, make you manage the repository easier.");
//
//  program.addCommand(new ListCommand(argv));
//  program.addCommand(new AddCommand(argv));
//  program.addCommand(new CleanCommand(argv));
//  program.addCommand(new RuntimeCommand(argv));
//  program.addCommand(new RemoveCommand(argv));
//  program.addCommand(new RelinkCommand(argv));
//
//  await prepare();
//
//  program.run(arguments).catchError((error) {
//    if (error is! UsageException) throw error;
//    print(error);
//    exit(64);
//  });
}