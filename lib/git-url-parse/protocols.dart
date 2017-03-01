library protocols;

/**
 * 获取url地址的协议proto
 * 返回一个字符串/数组
 */
protocols(String url, [bool first]) {
  int target = -1;

  if (first == true) target = 0;

  var index = url.indexOf("://");
  var splits = url.trim().substring(0, index).split("+");

  if (target is num && target >= 0) return splits[target];

  return splits;
}