import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/modules/login/widget/login_text_field.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/change_notifier_manage.dart';

class LoginContentWidget extends StatefulWidget {

  final LoginContentType type;

  const LoginContentWidget({super.key, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _LoginContentState();
  }
}

class _LoginContentState extends State<LoginContentWidget> with ChangeNotifierMixin<LoginContentWidget>  {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();

  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _nameController: callbacks,
      _vCodeController: callbacks,
      _pwdController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
      _nodeText3: null,
    };
  }

  void _verify() {
    final String name = _nameController.text;
    final String vCode = _vCodeController.text;
    final String password = _pwdController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (password.isEmpty || password.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      // setState(() {
      //   _clickable = clickable;
      // });
      // Provider.of(context)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPhoneWidget(),
        widget.type == LoginContentType.verifyCode
            ? _buildVCodeWidget()
            : _buildPwdWidget(),
      ],
    );
  }

  _buildPhoneWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "手机号",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18.sp,
                fontWeight: TextStyleUtils.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: JhImageUtils.getAssetImage("login/iconDengluShoujihao"),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 4),
              Text(
                "+86",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorUtils.black51,
                    fontSize: 16.sp,
                    fontWeight: TextStyleUtils.regual),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: LoginTextField(
                  focusNode: _nodeText1,
                  controller: _nameController,
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  hintText: "请输入手机号",
                ),
              )
            ],
          ),
          Divider(color: ColorUtils.rgb(216, 216, 216), height: 0.5),
        ],
      ),
    );
  }

  _buildVCodeWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "验证码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18.sp,
                fontWeight: TextStyleUtils.bold),
          ),
          Row(
            children: [
              Image(
                image: JhImageUtils.getAssetImage("login/iconDengluShoujihao"),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: LoginTextField(
                  focusNode: _nodeText2,
                  controller: _vCodeController,
                  maxLength: 6,
                  keyboardType: TextInputType.phone,
                  hintText: "请输入验证码",
                ),
              )
            ],
          ),
          Divider(color: ColorUtils.rgb(216, 216, 216), height: 0.5),
        ],
      ),
    );
  }

  _buildPwdWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "密码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18.sp,
                fontWeight: TextStyleUtils.bold),
          ),
          Row(
            children: [
              Image(
                image: JhImageUtils.getAssetImage("login/iconDengluShoujihao"),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: LoginTextField(
                  focusNode: _nodeText3,
                  controller: _pwdController,
                  maxLength: 11,
                  isInputPwd: true,
                  keyboardType: TextInputType.text,
                  hintText: "请输入密码",
                ),
              )
            ],
          ),
          Divider(color: ColorUtils.rgb(216, 216, 216), height: 0.5),
        ],
      ),
    );
  }

}


enum LoginContentType {
  verifyCode,
  pwd
}

