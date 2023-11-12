import 'package:flutter/material.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class WZBlockBtn extends StatefulWidget {
  final bool followed;
  final Future<bool> Function()? handleFollow;
  const WZBlockBtn({super.key, required this.followed, this.handleFollow});

  @override
  State<StatefulWidget> createState() {
    return WZBlockBtnState();
  }
}

class WZBlockBtnState extends State<WZBlockBtn> {
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
        alignment: Alignment.center,
        decoration: _isFollowd
            ? const BoxDecoration(
                color: Color.fromRGBO(216, 216, 216, 1.0),
                borderRadius: BorderRadius.all(Radius.circular(12)))
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorUtils.red233,
                    ColorUtils.red217,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12))),
        child: _isFollowd
            ? const Text('取消屏蔽',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: TextStyleUtils.regual))
            : const Text('屏蔽',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.regual)),
      ),
    );
  }
}
