import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wzty/app/routes.dart';
import 'package:wzty/common/widget/wz_back_button.dart';
import 'package:wzty/main/user/user_provider.dart';
import 'package:wzty/modules/login/provider/login_data_provider.dart';
import 'package:wzty/modules/login/widget/login_content_widget.dart';
import 'package:wzty/modules/login/service/login_service.dart';
import 'package:wzty/modules/login/widget/login_tabbar_item_widget.dart';
import 'package:wzty/main/tabbar/tab_provider.dart';
import 'package:wzty/modules/me/entity/user_info_entity.dart';
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

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  void _login() {
    ToastUtils.showLoading();

    String phone = _loginProvider.phone;
    String code;
    if (_loginProvider.isPwdLogin) {
      code = _loginProvider.pwd;
    } else {
      code = _loginProvider.pwd;
    }
    LoginService.requestLogin(phone, code, _loginProvider.isPwdLogin,
        (success, result) {
      ToastUtils.hideLoading();
      if (success) {
        context.read<UserProvider>().updateUserInfo(result);
        Routes.goBack(context);
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
                    image: JhImageUtils.getAssetImage("login/imgDengluBg", x2: false),
                    fit: BoxFit.fitWidth),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().statusBarHeight),
                  const WZBackButton(),
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
                                LoginTabbarItemWidget(tabName: '手机登录', index: 0),
                                LoginTabbarItemWidget(tabName: '密码登录', index: 1),
                              ]),
                          SizedBox(
                              height: 234, 
                              child: PageView.builder(
                                  key: const Key('pageView'),
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
                            return InkWell(
                              child: Container(
                                width: ScreenUtil().screenWidth-72*2,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: provider.canLogin
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
                                provider.canLogin ? _login() : null;
                              },
                            );
                          }),
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

  void _onPageChange(int index) {
    _tabProvider.setIndex(index);
    _tabController.animateTo(index);
  }
}
