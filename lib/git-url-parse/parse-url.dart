library parseUrl;

import 'protocols.dart' show protocols;
import 'is-ssh.dart' show isSsh;

Map<String, dynamic> parseUrl(String url) {
  var protos = protocols(url);
  String protocol = '';
  String resource = '';
  int port = null;
  String user = '';
  String pathname = '';
  String hash = '';
  String search = '';
  String href = '';

  int protocolIndex = url.indexOf("://");

  protocol = protos[0] ? protos[0] :
    () {
    if (isSsh(url)) {
      return 'ssh';
    } else if (url.codeUnitAt(1) == "/") {
      url = url.substring(2);
      return "";
    } else {
      return "file";
    }
  }();

  if (protocolIndex != -1) url = url.substring(protocolIndex + 3);

  List<String> parts = url.split("/");
  resource = parts.removeAt(0);

  // user@domain
  List<String> splits = resource.split("@");
  if (splits.length == 2) {
    user = splits[0];
    resource = splits[1];
  }


  // domain.com:port
  splits = resource.split(":");
  if (splits.length == 2) {
    resource = splits[0];
    port = num.parse(splits[1]);
    if (port is! num) {
      port = null;
      if (splits[1]
        .trim()
        .isNotEmpty) parts.insert(0, splits[1]);
    }
  }

  // Stringify the pathname
  pathname = "/" + parts.join("/");

  // #some-hash
  splits = pathname.split("#");
  if (splits.length == 2) {
    pathname = splits[0];
    hash = splits[1];
  }

  // ?foo=bar
  splits = pathname.split("?");
  if (splits.length == 2) {
    pathname = splits[0];
    search = splits[1];
  }

  return {
    "protocols": protos,
    "protocol": protocol,
    "resource": resource,
    "port": port,
    "user": user,
    "pathname": pathname,
    "hash": hash,
    "search": search,
    "href": href
  };
}