import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/common/eventBus/event_bus_event.dart';
import 'package:wzty/common/eventBus/event_bus_manager.dart';
import 'package:wzty/modules/login/widget/login_text_field.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/common/notifier/change_notifier_mixin.dart';

class LoginContentWidget extends StatefulWidget {

  final LoginContentType type;

  const LoginContentWidget({super.key, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _LoginContentState();
  }
}

class _LoginContentState extends State<LoginContentWidget> with ChangeNotifierMixin<LoginContentWidget>  {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];

    return <ChangeNotifier, List<VoidCallback>?>{
      _phoneController: callbacks,
      _pwdController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };

  }

  void _verify() {
    final String phone = _phoneController.text;
  
    bool clickable = false;  

    if (widget.type == LoginContentType.verifyCode) {
      final String pwd = _pwdController.text;

      if (phone.length == 11 && pwd.length == 6) {
        clickable = true;
      }
      if (clickable) {
        eventBusManager.emit(
            LoginEnableEvent(phone: phone, pwd: pwd, isPwdLogin: false));
      }
    } else {
      final String pwd = _pwdController.text;

      if (phone.length == 11 && pwd.length > 6) {
        clickable = true;
      }
      if (clickable) {
        eventBusManager.emit(
            LoginEnableEvent(phone: phone, pwd: pwd, isPwdLogin: true));
      }
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
                  controller: _phoneController,
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
                  controller: _pwdController,
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
                  focusNode: _nodeText2,
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

