import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/main/lib/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/common/widget/wz_verify_button.dart';
import 'package:wzty/main/dio/http_result_bean.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/modules/me/service/me_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class MeInfoAccountPage extends StatefulWidget {
  const MeInfoAccountPage({super.key});

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
      ToastUtils.showError(result.msg ?? result.data);
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

        ToastUtils.showSuccess("注销成功");

        UserManager.instance.removeUser();

        context.read<UserProvider>().updateUserInfo(null);

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
              SizedBox(height: 36.h),
              StatefulBuilder(builder: (context, setState) {
                _btnSetter = setState;
                return WZSureButton(
                    title: "确定注销",
                    handleTap: _requestSaveInfo,
                    enable: _btnEnable);
              }),
              SizedBox(height: 20.h),
              SizedBox(
                width: ScreenUtil().screenWidth-26,
                child: Text(
                """关于注销账户的特别说明：
（1）账号一旦注销，您将无法登录、使用该账号，也就是说您将无法在以此账号登录/使用/继续使用斗球的相关产品与服务；
（2）账号一旦注销，您曾通过该账号登录、使用的产品与服务下的所有内容、信息、数据、记录将会被删除或匿名化处理，您也无法再检索、访问、获取、继续使用和找回，也无权要求我们找回（但法律法规另有规定或监管部门另有要求的除外），包括：该账号下的个人资料（例如：头像、昵称）及绑定信息（例如：绑定手机号、邮箱）；该账号下的您的个人信息；该账号曾发表的所有内容（例如：图片、照片、评论、互动、点赞）；其他所有内容、信息、数据、记录。
（3）账号一旦注销。您与我们曾签署过的相关用户协议、其他权利义务性文件等相应终止（但我们与您之间已约定继续生效的或法律法规另有规定除外）；
（4）账号注销后，您的贵族、VIP、钱包余额权益将被完全删除。
（5）账号注销的处理期限为10日，也就是说，在您已成功向我们提交了斗球账号注销申请后的10日内（从成功提交申请之时起算），账号将被注销（本协议另有约定的除外）。""",
                style: TextStyle(
                    color: ColorUtils.black34,
                    fontSize: 12.sp,
                    fontWeight: TextStyleUtils.regual),
              ),
              )
            ],
          ),
        ));
  }
}
