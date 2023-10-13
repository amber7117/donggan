import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/modules/news/entity/news_list_entity.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

const double newsChildCellHeight = 100.0;

class NewChildCellWidget extends StatefulWidget {
  final NewsListModel model;

  const NewChildCellWidget({super.key, required this.model});

  @override
  State createState() => _NewChildCellWidgetState();
}

class _NewChildCellWidgetState extends State<NewChildCellWidget> {
  @override
  Widget build(BuildContext context) {
    NewsListModel model = widget.model;

    return InkWell(
      onTap: () {
        Routes.push(context, Routes.newsDetail, arguments: model.getNewsId());
      },
      child: Container(
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
      ),
    );
  }
}
