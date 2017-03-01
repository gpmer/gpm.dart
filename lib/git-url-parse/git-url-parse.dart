library GitUrlParser;

import 'git-up.dart' show gitUp;

Map<String, dynamic> gitUrlParse(String url) {
  if (url is! String) {
    throw new TypeError();
  }

  var urlInfo = gitUp(url);
  List<String> sourceParts = urlInfo["resource"].split(".");
  List<String> splits = null;

//  urlInfo["toString"-] = (type) {
//    return stringify(urlInfo, type);
//  };

  urlInfo["source"] = sourceParts.length > 2
    ? sourceParts.getRange(-2, 0).join(".")
    : urlInfo["source"] = urlInfo["resource"];

  urlInfo["name"] = urlInfo["pathname"].substring(1).replaceAll(new RegExp(r"\.git$"), "");
  urlInfo["owner"] = urlInfo["user"];
  urlInfo["organization"] = urlInfo["owner"];

  switch (urlInfo["source"]) {
    case "cloudforge.com":
      urlInfo["owner"] = urlInfo["user"];
      urlInfo["organization"] = sourceParts[0];
      break;
    default:
      splits = urlInfo["name"].split("/");
      if (splits.length == 2) {
        urlInfo["owner"] = splits[0];
        urlInfo["name"] = splits[1];
      }
      break;
  }

  urlInfo["full_name"] = urlInfo["owner"];
  if (urlInfo["name"]) {
    urlInfo["full_name"] && (urlInfo["full_name"] += "/");
    urlInfo["full_name"] += urlInfo["name"];
  }

  return urlInfo;
}

String stringify(Map<String, dynamic> obj, String type) {
  type = type.isNotEmpty ? type : ((obj["protocols"] && obj["protocols"].length)
    ? obj["protocols"].join('+')
    : obj["protocol"]);
  String port = obj["port"] ? ':${obj["port"]}' : '';
  String user = obj["user"] ? obj["user"] : 'git';
  switch (type) {
    case "ssh":
      final result = port.isNotEmpty ? 'ssh://${user}@${obj["resource"]}${port}/${obj["full_name"]}.git' :
      '${user}@${obj["resource"]}:${obj["full_name"]}.git';
      return result;
    case "git+ssh":
    case "ssh+git":
    case "ftp":
    case "ftps":
      return '${type}://${user}@${obj["resource"]}${port}/${obj["full_name"]}.git';
    case "http":
    case "https":
      var token = "";
      if (obj["token"]) {
        token = buildToken(obj);
      }
      return '${type}://${token}${obj["resource"]}${port}/${obj["full_name"]}';
    default:
      return obj["href"];
  }
}

/*!
 * buildToken
 * Builds OAuth token prefix (helper function)
 *
 * @name buildToken
 * @function
 * @param {GitUrl} obj The parsed Git url object.
 * @return {String} token prefix
 */
String buildToken(Map<String, dynamic> obj) {
  switch (obj["source"]) {
    case "bitbucket.org":
      return 'x-token-auth:${obj["token"]}@';
    default:
      return '${obj["token"]}@';
  }
}