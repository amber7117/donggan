import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/modules/login/provider/login_data_provider.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class LoginContentWidget extends StatefulWidget {

  final LoginContentType type;

  const LoginContentWidget({super.key, required this.type});

  @override
  State<StatefulWidget> createState() {
    return _LoginContentState();
  }
}

class _LoginContentState extends State<LoginContentWidget>  {

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(_phoneVerify);
    _pwdController.addListener(_codeVerify);
  }
  
  @override
  void dispose() {
    _phoneController.removeListener(_phoneVerify);
    _pwdController.removeListener(_codeVerify);

    super.dispose();
  }

  void _phoneVerify() {
    context.read<LoginDataProvider>().phone = _phoneController.text;
  }
  
  void _codeVerify() {
    LoginDataProvider loginProvider = context.read<LoginDataProvider>();
    if (widget.type == LoginContentType.pwd) {
      loginProvider.isPwdLogin = true;
      loginProvider.pwd = _pwdController.text;
    } else {
      loginProvider.verifyCode = _pwdController.text;
    }

    loginProvider.checkLoginStatue();
  }

  Future<bool> _requestVerifyCode() async {
    String phone = _phoneController.text;
    if (phone.isEmpty) {
      return false;
    }

    ToastUtils.showLoading();

    HttpResultBean result =
        await LoginService.requestVerifyCode(phone, VerifyCodeType.login);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.msg ?? result.data);
    }

    return result.isSuccess();
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
          const Text(
            "手机号",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18,
                fontWeight: TextStyleUtils.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const JhAssetImage("login/iconDengluShoujihao",
                  width: 20, height: 20),
              const SizedBox(width: 4),
              const Text(
                "+86",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorUtils.black51,
                    fontSize: 16,
                    fontWeight: TextStyleUtils.regual),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: WZTextField(
                  textType: WZTextFieldType.phone,
                  controller: _phoneController,
                  focusNode: _nodeText1,
                  hintText: "请输入手机号",
                ),
              )
            ],
          ),
          const Divider(color: ColorUtils.gray216, height: 0.5),
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
          const Text(
            "验证码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18,
                fontWeight: TextStyleUtils.bold),
          ),
          Row(
            children: [
              Image(
                image: JhImageUtils.getAssetImage("login/iconDengluYanzhengma"),
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: WZTextField(
                  textType: WZTextFieldType.verifyCode,
                  controller: _pwdController,
                  focusNode: _nodeText2,
                  hintText: "请输入验证码",
                  getVCode: () async {
                    return await _requestVerifyCode();
                  },
                ),
              )
            ],
          ),
          const Divider(color: ColorUtils.gray216, height: 0.5),
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
          const Text(
            "密码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black51,
                fontSize: 18,
                fontWeight: TextStyleUtils.bold),
          ),
          Row(
            children: [
              const JhAssetImage("login/iconDengluMima",
                  width: 20, height: 20),
              const SizedBox(width: 14),
              Expanded(
                child: WZTextField(
                  textType: WZTextFieldType.pwd,
                  controller: _pwdController,
                  focusNode: _nodeText2,
                  hintText: "请输入密码",
                ),
              )
            ],
          ),
          const Divider(color: ColorUtils.gray216, height: 0.5),
        ],
      ),
    );
  }

}


enum LoginContentType {
  verifyCode,
  pwd
}

