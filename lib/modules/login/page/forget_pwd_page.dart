import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/modules/login/widget/login_content_widget.dart';
import 'package:wzty/modules/login/widget/login_tabbar_item_widget.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class ForgetPwdPage extends StatefulWidget {
  const ForgetPwdPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgetPwdPageState();
  }
}

class _ForgetPwdPageState extends State {

  late String _phone;
  late String _pwd;
  bool _clickable = false;

  late StateSetter _loginBtnSetter;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _login() {
    // if (!_clickable) {
    //   return;
    // }
    // ToastUtils.showLoading();

    // LoginService.requestVerifyCode(_phone, VerifyCodeType.login, (result) {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: JhImageUtils.getAssetImage("login/imgDengluBg"),
                  fit: BoxFit.fitWidth),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtil().statusBarHeight),
                InkWell(
                  child: const Padding(
                      padding: EdgeInsets.all(11),
                      child: JhAssetImage("login/iconDengluBack",
                          width: 22, height: 22)),
                  onTap: () {
                    Routes.goBack(context);
                  },
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 34),
                  child: Text(
                    "您好，",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: TextStyleUtils.semibold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 34),
                  child: Text(
                    "欢迎使用王者体育",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: TextStyleUtils.semibold),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(131, 1, 20, 0.36), // 阴影颜色
                            spreadRadius: 4, // 阴影扩散程度
                            blurRadius: 18, // 阴影模糊程度
                            offset: Offset(0, 10), // 阴影偏移量
                          ),
                        ],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(22))),
                    child: Column(
                      children: [
                        const LoginTabbarItemWidget(tabName: '登录', index: 0),
                        const SizedBox(
                            height: 250, //208
                            child:
                                LoginContentWidget(type: LoginContentType.pwd)),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24))),
                              child: Text(
                                "登录",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
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
                ),
              ],
            ),
          ),
        ));
  }
}
