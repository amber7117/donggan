import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class FollowBtn extends StatefulWidget {
  const FollowBtn({super.key, this.getFollow, required this.followed});

  final bool followed;
  final Future<bool> Function()? getFollow;

  @override
  State<StatefulWidget> createState() {
    return FollowBtnState();
  }
}

class FollowBtnState extends State<FollowBtn> {
  late bool _isFollowd;

  @override
  void initState() {
    super.initState();
    _isFollowd = widget.followed;
  }

  Future<void> _getFollow() async {
    bool isSuccess = await widget.getFollow!();
    if (!isSuccess) return;

    setState(() {
      _isFollowd = !_isFollowd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getFollow,
      child: Container(
        width: 60,
        height: 24,
        decoration: BoxDecoration(
            gradient: _isFollowd
                ? null
                : const LinearGradient(
                    colors: [
                      Color.fromRGBO(233, 78, 78, 1.0),
                      Color.fromRGBO(217, 52, 52, 1.0),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isFollowd
                ? const SizedBox()
                : const JhAssetImage("common/iconGuanzhuJH", width: 16),
            Text('关注',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: TextStyleUtils.regual))
          ],
        ),
      ),
    );
  }
}