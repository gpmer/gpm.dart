import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:log/log.dart';

import 'package:gpmx/config.dart' as config;
import 'package:gpmx/utils.dart' show ensuredir, createTemp, readJson, writeJson;
import 'package:git_url_parse/git-url-parse.dart' show gitUrlParse;


Future addHandler(Map argv, Map options) async {
  final repository = argv["repo"];

  final gitInfo = gitUrlParse(repository);

  final Directory temp = await createTemp(config.TEMP);

  final Process process = await Process.start('git', ['clone', repository], workingDirectory: temp.path);

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

  final num exitCode = await process.exitCode;

  if (exitCode != 0) {
    await temp.delete(recursive: true);
    return throw new StackOverflowError();
  }

  try {
    await ensuredir(
      path.join(
        config.ROOT,
        gitInfo["source"]
      )
    );
    final Directory ownerdir = await ensuredir(
      path.join(
        config.ROOT,
        gitInfo["source"], gitInfo["owner"]
      )
    );

    final String targetPath = path.join(ownerdir.path, gitInfo["name"]);

    Directory targetDir = await ensuredir(targetPath);

    await targetDir.delete(recursive: true);

    await new Directory(path.normalize(
      path.join(temp.absolute.path, gitInfo["name"]))
    ).rename(targetPath);

    Log.success('clone in $targetDir');

    var lock = await readJson(config.LOCK);

    Set repos = new Set.from(lock["repos"] ? lock["repos"] : []);

    gitInfo["path"] = targetPath;
    repos.add(gitInfo);

    lock["repos"] = repos.toList(growable: true);

    await writeJson(config.LOCK, lock);
  } catch (exception, stackTrace) {
    print(exception);
    print(stackTrace);
  } finally {
    await temp.delete(recursive: true);
  }
}