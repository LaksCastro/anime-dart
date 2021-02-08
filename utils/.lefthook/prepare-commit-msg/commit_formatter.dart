import 'dart:io';

import 'package:path/path.dart';

import 'package:commit_formatter/commit_formatter.dart';

void main(List<String> args) {
  final commitFile = File(absolute(args[0]));
  final commitMessage = commitFile.readAsStringSync();

  final formatter = CommitlintFormatter();

  commitFile.writeAsStringSync(formatter.formatThis(commitMessage));
}
