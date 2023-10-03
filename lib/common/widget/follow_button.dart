import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class FollowBtn extends StatefulWidget {
  const FollowBtn({super.key, this.handleFollow, required this.followed});

  final bool followed;
  final Future<bool> Function()? handleFollow;

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

  Future<void> _handleTap() async {
    bool isSuccess = await widget.handleFollow!();
    if (!isSuccess) return;

    setState(() {
      _isFollowd = !_isFollowd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Container(
        width: 60,
        height: 24,
        decoration: _isFollowd
            ? BoxDecoration(
                border: Border.all(
                    width: 1.0,
                    color: const Color.fromRGBO(216, 216, 216, 1.0)),
                borderRadius: const BorderRadius.all(Radius.circular(4)))
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(233, 78, 78, 1.0),
                    Color.fromRGBO(217, 52, 52, 1.0),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isFollowd
                ? const SizedBox()
                : const JhAssetImage("common/iconGuanzhuJH", width: 16),
            Text('关注',
                style: TextStyle(
                    color: _isFollowd
                        ? const Color.fromRGBO(216, 216, 216, 1.0)
                        : Colors.white,
                    fontSize: 12.sp,
                    fontWeight: TextStyleUtils.regual))
          ],
        ),
      ),
    );
  }
}
