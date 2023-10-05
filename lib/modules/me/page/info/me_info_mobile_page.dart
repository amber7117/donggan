import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/appbar.dart';
import 'package:wzty/common/widget/wz_sure_button.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
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

  String _mobile = UserManager.instance.user?.getMobileDisplay();
  late StateSetter _btnSetter;

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(_mobileVerify);
  }

  @override
  void dispose() {
    _mobileController.removeListener(_mobileVerify);

    super.dispose();
  }

  void _mobileVerify() {
    if (_mobileController.text.length > 12) {
      _mobileController.text = _mobileController.text.substring(0, 12);
    }
    _mobile = _mobileController.text;

    _btnSetter(() {});
  }

  _requestSaveInfo() {
    Map<String, dynamic> params = {
      "nickName": _mobile,
    };
    
    ToastUtils.showLoading();
    MeService.requestModifyUserInfo(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        Routes.unfocus();

        ToastUtils.showSuccess("保存成功");

        UserManager.instance.updateUserNickName(_mobile);

        context.read<UserProvider>().updateUserInfoPart(nickName: _mobile);

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
                          _mobile,
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
                          child: WZTextField(
                            textType: WZTextFieldType.mobile,
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
                          "验证码将发送到您手机：$_mobile",
                          style: TextStyle(
                              color: ColorUtils.black34,
                              fontSize: 12.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                        Text(
                          "获取验证码",
                          style: TextStyle(
                              color: ColorUtils.red233,
                              fontSize: 12.sp,
                              fontWeight: TextStyleUtils.regual),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 333.h, width: double.infinity),
              StatefulBuilder(builder: (context, setState) {
                _btnSetter = setState;
                return WZSureButton(
                    title: "保存",
                    handleTap: _requestSaveInfo,
                    enable: _mobileController.text.isNotEmpty);
              })
            ],
          ),
        ));
  }
}
