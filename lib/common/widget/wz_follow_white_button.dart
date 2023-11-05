import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class WZFollowWhiteBtn extends StatefulWidget {
  const WZFollowWhiteBtn(
      {super.key, this.handleFollow, required this.followed});

  final bool followed;
  final Future<bool> Function()? handleFollow;

  @override
  State<StatefulWidget> createState() {
    return WZFollowWhiteBtnState();
  }
}

class WZFollowWhiteBtnState extends State<WZFollowWhiteBtn> {
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
        height: 22,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(11))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isFollowd
                ? const SizedBox()
                : const JhAssetImage("common/iconGuanzhuJH2", width: 12),
            _isFollowd
                ? const Text('已关注',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.medium))
                : const Text('关注',
                    style: TextStyle(
                        color: ColorUtils.red233,
                        fontSize: 10,
                        fontWeight: TextStyleUtils.medium))
          ],
        ),
      ),
    );
  }
}
