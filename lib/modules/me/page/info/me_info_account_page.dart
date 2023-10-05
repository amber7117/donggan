import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/common/widget/wz_verify_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeInfoAccountPage extends StatefulWidget {
  const MeInfoAccountPage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoAccountPageState();
}

class _MeInfoAccountPageState extends State<MeInfoAccountPage> {
  final TextEditingController _codeController = TextEditingController();

  final String _mobileOld = UserManager.instance.user?.getMobileDisplay();

  bool _btnEnable = false;
  late StateSetter _btnSetter;

  @override
  void initState() {
    super.initState();

    _codeController.addListener(_textVerify);
  }

  @override
  void dispose() {
    _codeController.addListener(_textVerify);

    super.dispose();
  }

  void _textVerify() {
    if (_codeController.text.isNotEmpty) {
      _btnEnable = true;
    } else {
      _btnEnable = false;
    }

    _btnSetter(() {});
  }

  Future<bool> _requestVerifyCode() async {
    String phone = UserManager.instance.user?.mobile ?? "";
    if (phone.isEmpty) return false;

    ToastUtils.showLoading();

    HttpResultBean result = await LoginService.requestVerifyCode(
        phone, VerifyCodeType.deleteAccount);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.data ?? result.msg);
    }
    return result.isSuccess();
  }

  _requestSaveInfo() {
    String code = _codeController.text;

    if (code.length > 6 || code.isEmpty) {
      ToastUtils.showInfo("请输入正确的验证码");
      return;
    }

    Map<String, dynamic> params = {
      "code": code,
      "type": "6",
    };
    ToastUtils.showLoading();
    MeService.requestModifyUserPwd(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        Routes.unfocus();

        ToastUtils.showSuccess("修改成功");

        Future.delayed(const Duration(seconds: 1), () {
          Routes.goBack(context);
        });
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorUtils.gray248,
        appBar: buildAppBar(context: context, titleText: "注销账号"),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Routes.unfocus();
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 144,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "验证码",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 16.sp,
                          fontWeight: TextStyleUtils.regual),
                    ),
                    WZTextField(
                      textType: WZTextFieldType.verifyCode,
                      controller: _codeController,
                      hintText: "请输入验证码",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "验证码将发送到您手机：$_mobileOld",
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                        WZVerifyBtn(handleVerify: _requestVerifyCode),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 36.h, width: double.infinity),
              StatefulBuilder(builder: (context, setState) {
                _btnSetter = setState;
                return WZSureButton(
                    title: "确定注销",
                    handleTap: _requestSaveInfo,
                    enable: _btnEnable);
              })
            ],
          ),
        ));
  }
}
