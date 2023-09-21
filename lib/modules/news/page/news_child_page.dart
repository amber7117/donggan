import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/colors.dart';
import 'package:wzty/utils/jh_image_utils.dart';

class NewsChildPage extends StatefulWidget {
  const NewsChildPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewsChildPageState();
  }
}

class _NewsChildPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        // itemExtent: 68,
        itemBuilder: (context, index) {
        return _buildCellWidget(index);
      }) ,
    );
  }

  _buildCellWidget(int idx) {
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
                    "卡尔作为西甲大使发言梅西仍有也！卡尔作为西甲大使发言梅西仍有也！",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ThemeColor.black34,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 12),
              Row(
                children: [
                  const JhAssetImage("news/iconMessage",
                      width: 16.0, height: 16.0),
                  const SizedBox(width: 2),
                  Text(
                    "1256",
                    style: TextStyle(
                        color: ThemeColor.gray153,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          const Expanded(child: JhAssetImage("common/imgZixunMoren",
                width: 94.0, height: 70.0),
          ),
          
        ],
      ),
    );
  }
}
