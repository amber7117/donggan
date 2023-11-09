import 'package:wzty/utils/shared_preference_utils.dart';

class SearchManager {
  final List<String> _keyWordArr = [];

  // ---------------------------------------------

  Future<List<String>> obtainKeyWordData() async {
    if (_keyWordArr.isEmpty) {
      String keywordStr = await SpUtils.getString(SpKeys.searchHistory);

      if (keywordStr.isNotEmpty) {
        _keyWordArr.addAll(keywordStr.split(","));
      }
    }
    return _keyWordArr;
  }

  void updateKeyWordData(String keyWord) {
    int idx = _keyWordArr.indexOf(keyWord);
    if (idx != -1) {
      _keyWordArr.removeAt(idx);
    }
    _keyWordArr.insert(0, keyWord);

    SpUtils.save(SpKeys.searchHistory, _keyWordArr.join(","));
  }

  void cleanAllKeyWord() {
    _keyWordArr.clear();

    SpUtils.save(SpKeys.searchHistory, "");
  }

  // ---------------------------------------------

  factory SearchManager() => _getInstance;

  static SearchManager get instance => _getInstance;

  static final SearchManager _getInstance = SearchManager._internal();

  SearchManager._internal();
}
