library gpmx;

import 'dart:async';

import 'package:escli/escli.dart' show program;

import 'prepare.dart' show prepare;

// commands
import './commands/add.dart' show addHandler;
import './commands/list.dart' show listHandler;
import './commands/clean.dart' show cleanHandler;
import './commands/runtime.dart' show runtimeHandler;
import './commands/remove.dart' show removeHandler;
import './commands/relink.dart' show relinkHandler;
import './commands/import.dart' show importHandler;

Future bootstrap(List<String> arguments) async {
  await prepare();
  program
    ..name('gpmx')
    ..description('Git Package Manager, make you manage the repository easier, Power by Dart')
    ..usage('<command> [options]')
    ..action((Map argv, Map options) {
      print('run default action');
    });

  program
    .command('list', 'display the all repo.')
    .action(listHandler);

  program
    .command('add <repo>', 'clone repo into local dir.')
    .action(addHandler);

  program
    .command('remove', 'remove a repo.')
    .action(removeHandler);

  program
    .command('clean', 'clean the temp/cache.')
    .action(cleanHandler);

  program
    .command('runtime', 'print the program runtime, useful for submit a issue.')
    .action(runtimeHandler);

  program
    .command('relink', 'relink the base dir which contain repositories if you delete repository manually.')
    .action(relinkHandler);

  program
    .command('import <dir>', 'register a repository to GPM.')
    .option('--all', 'import all the repositories in the current directory into GPM')
    .option('--hard', 'import the repository in hard mode, it will move the repository into GPM container not just link')
    .option("-f, --force", "forced import, that mean you don't care the replace the old dir or not, just do it.")
    .action(importHandler);

  program.parseArgv(arguments);
}