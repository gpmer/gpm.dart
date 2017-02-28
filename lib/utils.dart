import 'dart:io';
import 'dart:async';

Future<List<FileSystemEntity>> readdir(String dirStr) {
  final dir = new Directory(dirStr);
  var files = <FileSystemEntity>[];
  var completer = new Completer();
  var lister = dir.list(recursive: false);
  lister.listen (
      (file) => files.add(file),
    // should also register onError
    onDone:   () => completer.complete(files)
  );
  return completer.future;
}