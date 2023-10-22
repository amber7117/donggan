import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/search/page/search_history_page.dart';
import 'package:wzty/modules/search/page/search_result_page.dart';
import 'package:wzty/modules/search/service/search_service.dart';
import 'package:wzty/modules/search/widget/search_text_widget.dart';
import 'package:wzty/utils/toast_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;

  _requestSearch(String keyword) {
    ToastUtils.showLoading();

    SearchService.requestSearchData(keyword, (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        if (result != null) {
          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().statusBarHeight),
            Row(
              children: [
                const WZBackBlackButton(),
                Expanded(child: SearchTextWidget(callback: (data) {
                  _requestSearch(data);
                })),
                const SizedBox(width: 12),
              ],
            ),
            const Expanded(
              child: Stack(
                children: [
                  Visibility(
                    visible: true,
                    child: SearchHistoryPage(),
                  ),
                  Visibility(
                    visible: false,
                    child: SearchResultPage(),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
