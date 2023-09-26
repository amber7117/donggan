String signGetRequest(dynamic param, String md5Key, String milliseconds) {
  List<String> keyValues = [];

  if (param is Map<String, dynamic>) {
    List<String> allKeyArray = param.keys.toList();
    List<String> afterSortKeyArray = allKeyArray..sort();

    List<String> valueArray = [];
    for (String sortedString in afterSortKeyArray) {
      String valueString = (param[sortedString] as String?) ?? "";
      valueArray.add(valueString);
    }

    for (int idx = 0; idx < afterSortKeyArray.length; idx++) {
      keyValues.add("${afterSortKeyArray[idx]}=${valueArray[idx]}");
    }
  }

  if (md5Key.isNotEmpty) {
    keyValues.add("key=$md5Key");
  }

  if (milliseconds.isNotEmpty) {
    keyValues.add("t=$milliseconds");
  }

  String keyValueStr = keyValues.join('&');

  return sha1
      .convert(utf8.encode(md5.convert(utf8.encode(keyValueStr)).toString()))
      .toString();
}
