library isSsh;

import 'protocols.dart' show protocols;

bool isSsh(String input) {
  if (input is List) {
    return input.indexOf("ssh") != -1 || input.indexOf("rsync") != -1;
  }

  if (input is! String) {
    return false;
  }

  final proto = protocols(input);
  input = input.substring(input.indexOf("://") + 3);

  if (isSsh(proto)) {
    return true;
  }

  // TODO This probably could be improved :)
  return input.indexOf("@") < input.indexOf(":");
}