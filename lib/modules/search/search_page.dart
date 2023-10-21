import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/modules/search/page/search_history_page.dart';
import 'package:wzty/modules/search/widget/search_text_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().statusBarHeight),
            const Row(
              children: [
                WZBackBlackButton(),
                Expanded(child: SearchTextWidget()),
                SizedBox(width: 12),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  SearchHistoryPage(),
                ],
              ),
            )
          ],
        ));
  }
}
