library config;

import 'dart:io' show Platform;

import 'package:path/path.dart' as path;

String _getHomeDir() {
  String os = Platform.operatingSystem;
  String home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home;
}

final String NAME = 'gpmx';
final String HOME = _getHomeDir();
final String ROOT = path.normalize(path.join(HOME, '$NAME'));
final String GLOBAL = path.normalize(path.join(HOME, '.$NAME'));
final String CONFIG = path.normalize(path.join(GLOBAL, '$NAME.config.json'));
final String TEMP = path.normalize(path.join(GLOBAL, 'temp'));
final String LOCK = path.normalize(path.join(GLOBAL, '$NAME.lock.json'));