import 'dart:async';
import 'dart:convert';

import 'package:log/log.dart';
import 'package:args/command_runner.dart' show Command;

import '../config.dart' as config;
import '../utils.dart' show readJson;


class ListCommand extends Command {
  final name = "list";
  final aliases = ['ls'];
  final description = "display the all repo.";
  var argv = null;

  ListCommand(__argv) {
    argv = __argv;
  }

  Future run() async {

  }
}