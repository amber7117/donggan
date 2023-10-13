import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/modules/news/entity/news_list_entity.dart';
import 'package:wzty/modules/news/service/news_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class NewsChildPage extends StatefulWidget {
  const NewsChildPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewsChildPageState();
  }
}

class _NewsChildPageState extends KeepAliveLifeWidgetState {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<NewsListModel> _dataArr = [];

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  _requestData() {
    ToastUtils.showLoading();

    NewsService.requestHotList(1, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        if (result.isNotEmpty) {
          _dataArr = result;

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
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: Scaffold(
            backgroundColor: ColorUtils.gray248, body: _buildChild(context)));
  }

  _buildChild(BuildContext context) {
    if (_dataArr.isEmpty) {
      return const SizedBox();
    }

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _dataArr.length,
        itemExtent: 100,
        itemBuilder: (context, index) {
          return _buildCellWidget(index);
        });
  }

  _buildCellWidget(int idx) {
    NewsListModel model = _dataArr[idx];
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 240.w,
                  child: Text(
                    model.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ColorUtils.black34,
                        fontSize: 14.sp,
                        fontWeight: TextStyleUtils.medium),
                  )),
              const SizedBox(height: 12),
              Row(
                children: [
                  const JhAssetImage("news/iconMessage",
                      width: 16.0, height: 16.0),
                  const SizedBox(width: 2),
                  Text(
                    "${model.commentCount}",
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 14.sp,
                        fontWeight: TextStyleUtils.regual),
                  ),
                ],
              ),
            ],
          ),
          ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: buildNetImage(model.imgUrl,
                  width: 94.0,
                  height: 70.0,
                  placeholder: "common/imgZixunMoren")),
        ],
      ),
    );
  }
  
  @override
  bool isAutomaticKeepAlive() {
    return true;
  }
  
}
