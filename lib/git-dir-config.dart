import 'dart:io';
import 'dart:async';

import 'package:path/path.dart' as path;

Future gitDirParse(String dir) async {
  final String configRaw = await new File(path.join(dir, 'config')).readAsString();
  final List<String> configList = configRaw.split(new RegExp(r'\n'));

  final Iterable<Match> matcher = new RegExp(r'url\s?=\s?[^\n]+').allMatches(configRaw);

  String url = '';

  for (Match m in matcher) {
    final String urlGroup = m.group(0);
    final List<String> urlMatch = urlGroup.split(new RegExp(r'\s?=\s?'));
    url = urlMatch[1].trim();
  }

  return url;
}