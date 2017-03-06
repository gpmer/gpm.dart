import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';
import 'package:prompt/prompt.dart';

import '../config.dart' as config;
import '../utils.dart' show readJson, removedir, writeJson;

Future removeHandler(Map argv, Map options) async {
  final lock = await readJson(config.LOCK);

  Set repositories = new Set.from(lock["repos"]);
  if (repositories.isEmpty) repositories = new Set();

  final allowed = repositories.map((repo) {
    return repo["path"];
  }).toList();

  Log.message('You can Press [CTRL+C] to cancle this action.');

  final answer = await prompt.ask(
    new Question(
      'whitch one you wanna remove, Enter the flowing Index or CTRL+C to cancel', defaultsTo: allowed.first, allowed: allowed
    )
  );

  close();

  Map target;
  repositories.forEach((repo) {
    if (repo["path"] == answer) target = repo;
  });

  repositories.remove(target);

  lock["repos"] = repositories.toList();

  await writeJson(config.LOCK, lock);

  await removedir(target["path"]);

  Log.message('${target["path"]} has been remove');
}