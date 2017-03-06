import 'dart:async';
import 'dart:convert';

import 'package:log/log.dart';

import 'package:gpmx/config.dart' as config;
import 'package:gpmx/utils.dart' show readJson;

Future listHandler(Map argv, Map options) async {
  final lock = await readJson(config.LOCK);

  List repos = new List.from(lock["repos"]);

  if (repos.isEmpty) repos = new List();

  if (repos.isEmpty) {
    return Log.message('You did not add any repository yet, try run command line: ${config.NAME} add <repo> [options]');
  }

  var output = new Map();

  while (repos.isNotEmpty) {
    Map repo = repos.removeLast();
    String source = repo["source"];
    String owner = repo["owner"];
    String name = repo["name"];
    String path = repo["path"];
    Map<String, dynamic> sourceMap = output.containsKey(source) ? output[source] : new Map();
    Map<String, dynamic> ownerMap = sourceMap.containsKey(owner) ? sourceMap[owner] : new Map();
    ownerMap[name] = path;
    sourceMap[owner] = ownerMap;

    output[source] = sourceMap;
  }

  print(new JsonEncoder.withIndent('  ').convert(output));
}