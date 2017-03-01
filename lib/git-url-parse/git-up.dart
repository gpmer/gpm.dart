library gitUp;

import 'parse-url.dart';
import 'is-ssh.dart';

Map<String, dynamic> gitUp(String input) {

  var output = parseUrl(input);
  output["token"] = "";

  List splits = output["user"].split(":");
  if (splits.length == 2) {
    if (splits[1] == "x-oauth-basic") {
      output["token"] = splits[0];
    } else if (splits[0] == "x-token-auth") {
      output["token"] = splits[1];
    }
  }

  if (isSsh(output["protocols"]) || isSsh(input)) {
    output["protocol"] = "ssh";
  } else if (output["protocols"].length) {
    output["protocol"] = output["protocols"][0];
  } else {
    output["protocol"] = "file";
  }

  return output;
}