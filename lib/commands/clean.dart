import 'dart:io';
import 'dart:async';

import 'package:log/log.dart';

import '../config.dart' as config;

Future cleanHandler(Map argv, Map options) async {
  await new Directory(config.TEMP).delete(recursive: true);

  Log.message('cache clean');
}