import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class WZFollowBtn extends StatefulWidget {
  final bool followed;
  final Future<bool> Function()? handleFollow;
  const WZFollowBtn({super.key, required this.followed, this.handleFollow});

  @override
  State<StatefulWidget> createState() {
    return WZFollowBtnState();
  }
}

class WZFollowBtnState extends State<WZFollowBtn> {
  late bool _isFollowd;

  @override
  void initState() {
    super.initState();
    _isFollowd = widget.followed;
  }

  Future<void> _handleTap() async {
    if (widget.handleFollow == null) return;

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
                    ColorUtils.red233,
                    ColorUtils.red217,
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
            _isFollowd
                ? const Text('已关注',
                    style: TextStyle(
                        color: Color.fromRGBO(216, 216, 216, 1.0),
                        fontSize: 12,
                        fontWeight: TextStyleUtils.regual))
                : const Text('关注',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: TextStyleUtils.regual))
          ],
        ),
      ),
    );
  }
}
