import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/common/widget/wz_text_field_right.dart';
import 'package:wzty/common/widget/wz_verify_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeInfoMobilePage extends StatefulWidget {
  const MeInfoMobilePage({Key? key}) : super(key: key);

  @override
  State createState() => _MeInfoMobilePageState();
}

class _MeInfoMobilePageState extends State<MeInfoMobilePage> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  final String _mobileOld = UserManager.instance.user?.getMobileDisplay();
  
  bool _btnEnable = false;
  late StateSetter _btnSetter;

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(_textVerify);
    _codeController.addListener(_textVerify);
  }

  @override
  void dispose() {
    _mobileController.removeListener(_textVerify);
    _codeController.addListener(_textVerify);

    super.dispose();
  }

  void _textVerify() {
    if (_mobileController.text.isNotEmpty && _codeController.text.isNotEmpty) {
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

    HttpResultBean result =
        await LoginService.requestVerifyCode(phone, VerifyCodeType.modifyInfo);

    ToastUtils.hideLoading();
    if (!result.isSuccess()) {
      ToastUtils.showError(result.data ?? result.msg);
    }
    return result.isSuccess();
  }

  _requestSaveInfo() {
    String phone = _mobileController.text;
    String code = _codeController.text;

    if (phone.length < 11) {
      ToastUtils.showInfo("请输入11位的手机号");
      return;
    }
    if (code.length > 6 || code.isEmpty) {
      ToastUtils.showInfo("请输入正确的验证码");
      return;
    }

    Map<String, dynamic> params = {
      "areaNo": "86",
      "mobile": phone,
      "code": code
    };

    ToastUtils.showLoading();
    MeService.requestModifyUserMobile(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        Routes.unfocus();

        ToastUtils.showSuccess("修改成功");

        UserManager.instance.updateUserMobile(phone);

        context.read<UserProvider>().updateUserInfoPart(mobile: phone);

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
        appBar: buildAppBar(context: context, titleText: "修改手机号"),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Routes.unfocus();
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 105,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "手机号",
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 16.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                        Text(
                          _mobileOld,
                          style: TextStyle(
                              color: ColorUtils.gray149,
                              fontSize: 16.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "中国 +86",
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 16.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                        SizedBox(
                          width: 200,
                          child: WZTextFieldRight(
                            textType: WZTextFieldRightType.mobile,
                            controller: _mobileController,
                            focusNode: _nodeText1,
                            hintText: "请输入手机号",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
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
                      focusNode: _nodeText2,
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
              SizedBox(height: 333.h),
              StatefulBuilder(builder: (context, setState) {
                _btnSetter = setState;
                return WZSureButton(
                    title: "确定",
                    handleTap: _requestSaveInfo,
                    enable: _btnEnable);
              })
            ],
          ),
        ));
  }
}
