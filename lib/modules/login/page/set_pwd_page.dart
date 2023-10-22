import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/common/widget/wz_text_field.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class SetPwdPage extends StatefulWidget {
  const SetPwdPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SetPwdPageState();
  }

}

 class _SetPwdPageState  extends State {

  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  
  late String _pwd;

  bool _clickable = false;

  late StateSetter _loginBtnSetter;

  @override
  void initState() {
    super.initState();

    _pwdController.addListener(() {

    });
  }

  @override
  void dispose() {
    _pwdController.dispose();

    super.dispose();
  }

  void _login() {
    // if (!_clickable) {
    //   return;
    // }
    // ToastUtils.showLoading();

    // LoginService.requestVerifyCode(_pwd, VerifyCodeType.login, (result) {
    //   ToastUtils.hideLoading();
    //   if (result.isEmpty) {
    //     ToastUtils.showSuccess("发送成功");
    //   } else {
    //     ToastUtils.showError(result);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Container(
        height: 225.h,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "设置登录密码",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.black34,
                  fontSize: 14,
                  fontWeight: TextStyleUtils.bold),
            ),
            const Text(
              "下次登录更方便，请输入您的密码",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorUtils.gray153,
                  fontSize: 12,
                  fontWeight: TextStyleUtils.regual),
            ),
            Expanded(
              child: WZTextField(
                textType: WZTextFieldType.phone,
                controller: _pwdController,
                focusNode: _nodeText1,
                hintText: "请输入手机号",
              ),
            ),
            StatefulBuilder(builder: (context, setState) {
              _loginBtnSetter = setState;
              return InkWell(
                child: Container(
                  width: double.infinity,
                  height: 48,
                  margin: const EdgeInsets.only(
                      top: 20, left: 54, right: 54, bottom: 20),
                  padding: const EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                      color: _clickable
                          ? ColorUtils.red235
                          : ColorUtils.red235.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24))),
                  child: const Text(
                    "登录",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: TextStyleUtils.bold),
                  ),
                ),
                onTap: () {
                  _login();
                },
              );
            })
          ],
        ),
      ),
    );
  }

 }