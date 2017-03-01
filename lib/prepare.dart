import 'dart:async';

import 'config.dart' as config;
import 'utils.dart' show ensuredir, ensurefile, readJson, writeJson;

Future prepare() async {
  await ensuredir(config.GLOBAL);

  await Future.wait([
    ensuredir(config.TEMP),
    ensurefile(config.LOCK),
    ensurefile(config.CONFIG)
  ]);

  List<Object> jsons = await Future.wait([
    readJson(config.CONFIG),
    readJson(config.LOCK)
  ]);

  // empty config
  if (jsons[0] == {}) {
    await writeJson(config.CONFIG, {"base": "gpmx"});
  }

  // empty
  if (jsons[1] == {}) {
    await writeJson(config.LOCK, {});
  }
}