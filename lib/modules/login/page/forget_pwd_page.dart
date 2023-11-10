import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/modules/login/page/set_pwd_page.dart';
import 'package:wzty/modules/login/provider/login_data_provider.dart';
import 'package:wzty/modules/login/widget/login_content_widget.dart';
import 'package:wzty/modules/login/service/login_service.dart';
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

class _ForgetPwdPageState extends State with SingleTickerProviderStateMixin {
  final LoginDataProvider _loginProvider = LoginDataProvider();

  void _login() {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return SetPwdPage(phone: "phone", ticket: "result");
    //     });
    //     return;
    
    ToastUtils.showLoading();

    String phone = _loginProvider.phone;
    String code = _loginProvider.verifyCode;

    LoginService.requestSetPwdTicket(phone, code, (success, result) { 
      ToastUtils.hideLoading();
      if (success) {
        showDialog(context: context, builder: (context) {
          return SetPwdPage(type: SetPwdType.forgetSetPwd, phone: phone, ticket: result);
        });
      } else {
        ToastUtils.showError(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _loginProvider),
      ],
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              Routes.unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: JhImageUtils.getAssetImage("login/imgDengluBg",
                        x2: false),
                    fit: BoxFit.fitWidth),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().statusBarHeight),
                  const WZBackButton(),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      "您好，",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: TextStyleUtils.semibold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      "欢迎使用王者体育",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
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
                          _buildTitleWidget(),
                          const SizedBox(
                              height: 234,
                              child: LoginContentWidget(
                                  type: LoginContentType.forgetPwd)),
                          Consumer<LoginDataProvider>(
                              builder: (context2, provider, child) {
                            return _buildLoginBtnWidget(provider.canLogin);
                          }),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _buildTitleWidget() {
    return SizedBox(
      width: (ScreenUtil().screenWidth - 18 * 2) * 0.5,
      height: 48.0,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "忘记密码",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.black34,
                fontSize: 14,
                fontWeight: TextStyleUtils.semibold),
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  color: ColorUtils.red235,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              child: SizedBox(height: 4, width: 16))
        ],
      ),
    );
  }

  _buildLoginBtnWidget(bool canLogin) {
    return InkWell(
      onTap: canLogin ? _login : null,
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(left: 62, right: 62),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: canLogin
                ? ColorUtils.red235
                : ColorUtils.red235.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        child: const Text(
          "下一步",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: TextStyleUtils.bold),
        ),
      ),
      
    );
  }
}
