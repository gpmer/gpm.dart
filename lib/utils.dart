import 'dart:io';
import 'dart:async';

Future<List<FileSystemEntity>> readdir(String dirStr) {
  final dir = new Directory(dirStr);
  var files = <FileSystemEntity>[];
  var completer = new Completer();
  var lister = dir.list(recursive: false);
  lister.listen((file) => files.add(file),
      // should also register onError
      onDone: () => completer.complete(files)
  );
  return completer.future;
}

Future ensuredir(String dirStr) async {
  var isExistComplete = new Completer();
  Directory dir = new Directory(dirStr);
  dir.exists()
      .then((isExist) {
    isExistComplete.complete(isExist);
  })
      .catchError(() {
    isExistComplete.complete(false);
  });

  bool isExist = await isExistComplete.future;

  if (!isExist) {
    await dir.create();
  }
  return dir;
}

Future ensurefile(String fileStr) async {
  var isExistComplete = new Completer();
  File file = new File(fileStr);
  file.exists()
      .then((isExist) {
    isExistComplete.complete(isExist);
  })
      .catchError(() {
    isExistComplete.complete(false);
  });

  bool isExist = await isExistComplete.future;

  if (!isExist) {
    await file.create();
  }
  return file;
}

main() async {
  await ensurefile('./abb');
}