import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/search/manager/search_manager.dart';
import 'package:wzty/modules/search/widget/search_history_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class SearchHistoryPage extends StatefulWidget {
  final WZAnyCallback callback;
  
  const SearchHistoryPage({super.key, required this.callback});

  @override
  State createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  List<String> _keyWordArr = [];

  @override
  void initState() {
    super.initState();

    _keyWordArr = SearchManager.instance.keyWordArr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 14),
      const Row(
        children: [
          SizedBox(width: 12),
          Expanded(
            child: Text("搜索历史",
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14,
                    fontWeight: TextStyleUtils.bold)),
          ),
          Row(
            children: [
              JhAssetImage("common/iconDelete", width: 18),
              SizedBox(width: 6),
              Text("清除",
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 12,
                      fontWeight: TextStyleUtils.regual)),
            ],
          ),
          SizedBox(width: 12),
        ],
      ),
      const SizedBox(height: 8),
      Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: searchHistoryCellAspect,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: _keyWordArr.length,
          itemBuilder: (BuildContext context, int index) {
            return SearchHistoryCellWidget(keyWord: _keyWordArr[index], callback: (data) {
              widget.callback(data);
            });
          },
        ),
      ),
    ]);
  }
}
