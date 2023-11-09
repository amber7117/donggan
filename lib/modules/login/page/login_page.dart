import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/eventBus/event_bus_event.dart';
import 'package:wzty/main/eventBus/event_bus_manager.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/login/provider/login_data_provider.dart';
import 'package:wzty/modules/login/widget/login_content_widget.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/modules/login/widget/login_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';
import 'package:wzty/utils/toast_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  final TabProvider _tabProvider = TabProvider();
  final LoginDataProvider _loginProvider = LoginDataProvider();

  bool _agreeProtocol = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
    _pageController.dispose();
  }

  void _login() {
    if (!_agreeProtocol) {
      ToastUtils.showInfo("请同意用户协议");
      return;
    }

    ToastUtils.showLoading();

    String phone = _loginProvider.phone;
    String code;
    if (_tabController.index == 1) {
      code = _loginProvider.pwd;
    } else {
      code = _loginProvider.verifyCode;
    }
    LoginService.requestLogin(phone, code, _loginProvider.isPwdLogin,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        context.read<UserProvider>().updateUserInfo(result);
        Routes.goBack(context);

        eventBusManager.emit(LoginStatusEvent(login: true));
      } else {
        ToastUtils.showError(result as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _tabProvider),
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
                  Consumer<TabProvider>(
                      builder: (context2, provider, child) {
                    return _buildNavWidget(provider.index == 1);
                  }),
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
                          TabBar(
                              onTap: (index) {
                                if (!mounted) return;
                                _pageController.jumpToPage(index);
                              },
                              isScrollable: true,
                              controller: _tabController,
                              indicator: const BoxDecoration(),
                              labelPadding: EdgeInsets.zero,
                              tabs: const <Widget>[
                                LoginTabbarItemWidget(
                                    tabName: '手机登录', index: 0),
                                LoginTabbarItemWidget(
                                    tabName: '密码登录', index: 1),
                              ]),
                          SizedBox(
                              height: 234,
                              child: PageView.builder(
                                  itemCount: 2,
                                  onPageChanged: _onPageChange,
                                  controller: _pageController,
                                  allowImplicitScrolling: true,
                                  itemBuilder: (_, int index) {
                                    if (index == 0) {
                                      return const LoginContentWidget(
                                          type: LoginContentType.verifyCode);
                                    } else {
                                      return const LoginContentWidget(
                                          type: LoginContentType.pwd);
                                    }
                                  })),
                          Consumer<LoginDataProvider>(
                              builder: (context2, provider, child) {
                            return _buildLoginBtnWidget(provider.canLogin);
                          }),
                          const SizedBox(height: 20),
                          const Text(
                            "手机验证码直接登录，无需注册",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(202, 184, 184, 1),
                                fontSize: 10,
                                fontWeight: TextStyleUtils.regual),
                          ),
                          const Spacer(),
                          _buildProtocolWidget(),
                          SizedBox(height: ScreenUtil().bottomBarHeight + 20)
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

  _buildNavWidget(bool isPwdLogin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const WZBackButton(),
        Visibility(
          visible: isPwdLogin,
          child: InkWell(
            onTap: () {
              Routes.push(context, Routes.forgetPwd);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("忘记密码",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: TextStyleUtils.regual)),
            ),
          ),
        )
      ],
    );
  }

  _buildLoginBtnWidget(bool canLogin) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(left: 62, right: 62),
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: canLogin
                ? ColorUtils.red235
                : ColorUtils.red235.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
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
        canLogin ? _login() : null;
      },
    );
  }

  _buildProtocolWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            _agreeProtocol = !_agreeProtocol;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: JhAssetImage(
                _agreeProtocol ? "login/iconSelect" : "login/iconSelectNo",
                width: 16),
          ),
        ),
        const Text(
          "我已阅读并接受",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorUtils.red233,
              fontSize: 10,
              fontWeight: TextStyleUtils.regual),
        ),
        InkWell(
          onTap: () {
            Routes.push(context, Routes.webLocal, arguments: {
              "title": "隐私政策",
              "htmlName": "privacy-policy.html"
            });
          },
          child: const Text(
            "《隐私协议》",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.red233,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
        InkWell(
          onTap: () {
            Routes.push(context, Routes.webLocal, arguments: {
              "title": "用户协议",
              "htmlName": "user-agreement.html"
            });
          },
          child: const Text(
            "《用户协议》",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorUtils.red233,
                fontSize: 10,
                fontWeight: TextStyleUtils.regual),
          ),
        ),
      ],
    );
  }

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
