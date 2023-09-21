
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsTabbarItemWidget extends StatelessWidget {
  
  final String tabName;

  const NewsTabbarItemWidget({super.key, required this.tabName});
  
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        width: 98.0,
        child: Text(
          tabName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
