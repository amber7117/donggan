import 'package:wzty/utils/shared_preference_utils.dart';

class SearchManager {
  List<String> keyWordArr = [];

  // ---------------------------------------------
  
  void updateKeyWordData(String keyWord) {
    int idx = keyWordArr.indexOf(keyWord);
    if (idx != -1) {
      keyWordArr.removeAt(idx);
    }
    keyWordArr.insert(0, keyWord);

    SpUtils.save(SpKeys.searchHistory, keyWordArr.join(","));
  }

  void cleanAllKeyWord() {
    keyWordArr.clear();

    SpUtils.save(SpKeys.searchHistory, "");
  }

  // ---------------------------------------------

  factory SearchManager() => _getInstance;

  static SearchManager get instance => _getInstance;

  static final SearchManager _getInstance = SearchManager._internal();

  SearchManager._internal() {
    _obtainData();
  }

  _obtainData() async {
    String keywordStr = await SpUtils.getString(SpKeys.searchHistory);

    if (keywordStr.isNotEmpty) {
      keyWordArr.addAll(keywordStr.split(","));
    }
  }
}
