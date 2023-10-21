import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/search/widget/search_history_cell_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class SearchHistoryPage extends StatefulWidget {
  const SearchHistoryPage({super.key});

  @override
  State createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 14),
      Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Text("搜索历史",
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 14.sp,
                    fontWeight: TextStyleUtils.bold)),
          ),
          const JhAssetImage("common/iconDelete", width: 18),
          const SizedBox(width: 6),
          Text("清除",
              style: TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 12.sp,
                  fontWeight: TextStyleUtils.regual)),
          const SizedBox(width: 12),
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
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return SearchHistoryCellWidget();
          },
        ),
      ),
    ]);
  }
}
